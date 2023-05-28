// clang-format off
#include "vmlinux.h"
// clang-format on
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include "../libbpf/src/bpf_helpers.h"
#include "../libbpf/src/bpf_endian.h"

#define ETH_P_IP	0x0800
int k = 2;
#define MAX_COUNT 3
#define CLIENT 4
#define LB 5
#define POPULATION_SIZE 100
#define SEQUENCE_LENGTH 100
#define CHAR_SET "ABCDE"
#define PRIORITY_LEVELS {2, 2, 2, 2, 2}
#define TOURNAMENT_SIZE 5
#define CROSSOVER_RATE 0.8
#define MUTATION_RATE 0.3
#define GENERATIONS 1000
unsigned char bytes[4] = {0,0,0,0};

unsigned int IP_ADDRESS(w,x,y,z) {
    uint res = ((256*256*256*w) + (256*256*x) + (256*y) + z);
    return res;
}

void print_ip(unsigned int ip)
{
    bytes[0] = ip & 0xFF;
    bytes[1] = (ip >> 8) & 0xFF;
    bytes[2] = (ip >> 16) & 0xFF;
    bytes[3] = (ip >> 24) & 0xFF;   
    //printf("%d.%d.%d.%d\n", bytes[3], bytes[2], bytes[1], bytes[0]);        
}

static __always_inline __u16
csum_fold_helper(__u64 csum)
{
    int i;
#pragma unroll
    for (i = 0; i < 4; i++)
    {
        if (csum >> 16)
            csum = (csum & 0xffff) + (csum >> 16);
    }
    return ~csum;
}

static __always_inline __u16
iph_csum(struct iphdr *iph)
{
    iph->check = 0;
    unsigned long long csum = bpf_csum_diff(0, 0, (unsigned int *)iph, sizeof(struct iphdr), 0);
    return csum_fold_helper(csum);
}

struct S
{
    unsigned long long time;
};

typedef struct {
    int sequence[SEQUENCE_LENGTH];
    int fitness;
} Individual;

void initialize_population(Individual population[]);
void calculate_fitness(Individual *individual);
void tournament_selection(Individual population[], Individual *parent1, Individual *parent2);
void single_point_crossover(Individual *parent1, Individual *parent2, Individual *child1, Individual *child2);
void swap_mutation(Individual *individual);
int compare_individuals(const void *a, const void *b);

void genAlgo() {
    //srand(time(NULL));

    Individual population[POPULATION_SIZE];
    initialize_population(population);

    for (int generation = 0; generation < GENERATIONS; generation++) {
        qsort(population, POPULATION_SIZE, sizeof(Individual), compare_individuals);

        Individual new_population[POPULATION_SIZE];
        memcpy(new_population, population, POPULATION_SIZE * sizeof(Individual));

        for (int i = 1; i < POPULATION_SIZE; i += 2) {
            Individual parent1, parent2;
            tournament_selection(population, &parent1, &parent2);

            Individual child1, child2;
            single_point_crossover(&parent1, &parent2, &child1, &child2);

            swap_mutation(&child1);
            swap_mutation(&child2);

            calculate_fitness(&child1);
            calculate_fitness(&child2);

            new_population[i - 1] = child1;
            new_population[i] = child2;
        }

        memcpy(population, new_population, POPULATION_SIZE * sizeof(Individual));
    }

    qsort(population, POPULATION_SIZE, sizeof(Individual), compare_individuals);
    //printf("Best sequence (fitness = %d): ", population[0].fitness);
    //for (int i = 0; i < SEQUENCE_LENGTH; i++) {
    //    printf("%c", CHAR_SET[population[0].sequence[i]]);
    //}
    //printf("\n");
}

void initialize_population(Individual population[]) {
    for (int i = 0; i < POPULATION_SIZE; i++) {
        for (int j = 0; j < SEQUENCE_LENGTH; j++) {
            population[i].sequence[j] = rand() % strlen(CHAR_SET);
        }
        calculate_fitness(&population[i]);
    }
}

void calculate_fitness(Individual *individual) {
    int priority_levels[] = PRIORITY_LEVELS;
    int sum = 0;
    for (int i = 0; i < SEQUENCE_LENGTH; i++) {
        sum += priority_levels[individual->sequence[i]];
    }
    individual->fitness = sum;
}

void tournament_selection(Individual population[], Individual *parent1, Individual *parent2) {
    *parent1 = population[rand() % POPULATION_SIZE];
    *parent2 = population[rand() % POPULATION_SIZE];

    for (int i = 1; i < TOURNAMENT_SIZE; i++) {
        Individual candidate1 = population[rand() % POPULATION_SIZE];
        Individual candidate2 = population[rand() % POPULATION_SIZE];

        if (candidate1.fitness < parent1->fitness) {
            *parent1 = candidate1;
        }
        if (candidate2.fitness < parent2->fitness) {
            *parent2 = candidate2;
        }
    }
}

void single_point_crossover(Individual *parent1, Individual *parent2, Individual *child1, Individual *child2) {
    if (rand() / (float)RAND_MAX < CROSSOVER_RATE) {
        int crossover_point = rand() % SEQUENCE_LENGTH;

        memcpy(child1->sequence, parent1->sequence, crossover_point * sizeof(int));
        memcpy(child1->sequence + crossover_point, parent2->sequence + crossover_point, (SEQUENCE_LENGTH - crossover_point) * sizeof(int));

        memcpy(child2->sequence, parent2->sequence, crossover_point * sizeof(int));
        memcpy(child2->sequence + crossover_point, parent1->sequence + crossover_point, (SEQUENCE_LENGTH - crossover_point) * sizeof(int));
    } else {
        *child1 = *parent1;
        *child2 = *parent2;
    }
}

void swap_mutation(Individual *individual) {
    if (rand() / (float)RAND_MAX < MUTATION_RATE) {
        int index1 = rand() % SEQUENCE_LENGTH;
        int index2 = rand() % SEQUENCE_LENGTH;

        int temp = individual->sequence[index1];
        individual->sequence[index1] = individual->sequence[index2];
        individual->sequence[index2] = temp;
    }
}

int compare_individuals(const void *a, const void *b) {
    return ((Individual *)a)->fitness - ((Individual *)b)->fitness;
}

SEC("xdp_lb")
int ark_lb_xdp(struct xdp_md *ctx) {
    void *data = (void *)(long)ctx->data;
    void *data_end = (void *)(long)ctx->data_end;

    //bpf_printk("Heya! arkLB here!", sizeof("Heya! arkLB here!"));
    
    struct ethhdr *eth = data;
    if (data + sizeof(struct ethhdr) > data_end)
        return XDP_ABORTED;

    if (bpf_ntohs(eth->h_proto) != ETH_P_IP)
        return XDP_PASS;

    struct iphdr *iph = data + sizeof(struct ethhdr);
    if (data + sizeof(struct ethhdr) + sizeof(struct iphdr) > data_end)
        return XDP_ABORTED;

    if (iph->protocol != IPPROTO_TCP) {
        bpf_printk("Got non-TCP packet", sizeof("Got non-TCP packet"));
        return XDP_PASS;
    }
        
    bpf_printk("Got TCP packet", sizeof("Got TCP packet"));
    bpf_printk("Source IP: %u", sizeof("Source IP: %u"), iph->saddr);
    // Change IP address here
    //uint32_t ip = IP_ADDRESS(164,113,193,34);
    //bpf_printk("Client IP: %u", sizeof("Client IP: %u"), ip);

    genAlgo();

    for(int i = 0; i < SEQUENCE_LENGTH; i++) {
        char be = 0;
        //bpf_printk("%c", sizeof("%c"), CHAR_SET[population[0].sequence[i]]);
        if(CHAR_SET[population[0].sequence[i]] == 'A') {
            //bpf_printk("A", sizeof("A"));
            be = 1;
            iph->daddr = IP_ADDRESS(127,0,0,be); // Dest IP here
            eth->h_dest[5] = be;
            bpf_printk("Got packet from client, sending to BE %d", sizeof("Got packet from client, sending to BE %d"), be);
        }
        else if(CHAR_SET[population[0].sequence[i]] == 'B') {
            //bpf_printk("B", sizeof("B"));
            be = 2;
            iph->daddr = IP_ADDRESS(127,0,0,be); // Dest IP here
            eth->h_dest[5] = be;
            bpf_printk("Got packet from client, sending to BE %d", sizeof("Got packet from client, sending to BE %d"), be);
        }
        else {
            iph->daddr = IP_ADDRESS(127,0,0,1); // Dest IP here
            eth->h_dest[5] = 1;
        }

        iph->check = iph_csum(iph);
        bpf_printk("Passing packet...", sizeof("Passing packet..."));
        return XDP_TX;
    }
}

char _license[] SEC("license") = "GPL";
