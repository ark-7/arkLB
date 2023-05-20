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
#define MAX_GENERATIONS 5
#define POPULATION_SIZE 100
#define NUM_SERVERS 10
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
    int server_indices[NUM_SERVERS];
    float fitness;
} Chromosome;

void initialize_population(Chromosome population[POPULATION_SIZE]);
void evaluate_fitness(Chromosome *chromosome);
void selection(Chromosome population[POPULATION_SIZE], Chromosome parents[POPULATION_SIZE]);
void crossover(Chromosome parents[POPULATION_SIZE], Chromosome offspring[POPULATION_SIZE]);
void mutation(Chromosome offspring[POPULATION_SIZE]);
int compare_fitness(const void *a, const void *b);

int main() {
    srand(time(NULL));

    Chromosome population[POPULATION_SIZE];
    Chromosome parents[POPULATION_SIZE];
    Chromosome offspring[POPULATION_SIZE];

    initialize_population(population);

    for (int generation = 0; generation < MAX_GENERATIONS; generation++) {
        for (int i = 0; i < POPULATION_SIZE; i++) {
            evaluate_fitness(&population[i]);
        }

        qsort(population, POPULATION_SIZE, sizeof(Chromosome), compare_fitness);

        selection(population, parents);
        crossover(parents, offspring);
        mutation(offspring);

        memcpy(population, offspring, POPULATION_SIZE * sizeof(Chromosome));
    }

    // Use the best chromosome (lowest fitness) to distribute packets
    Chromosome best_chromosome = population[0];
    // TODO: Implement packet distribution using the best chromosome

    return 0;
}

void initialize_population(Chromosome population[POPULATION_SIZE]) {
    for (int i = 0; i < POPULATION_SIZE; i++) {
        for (int j = 0; j < NUM_SERVERS; j++) {
            population[i].server_indices[j] = rand() % NUM_SERVERS;
        }
    }
}

void evaluate_fitness(Chromosome *chromosome) {
    // TODO: Implement a fitness function based on the network conditions and server load
    chromosome->fitness = 0;
    
}

void selection(Chromosome population[POPULATION_SIZE], Chromosome parents[POPULATION_SIZE]) {
    // TODO: Implement a selection method (e.g., tournament selection, roulette wheel selection)

}

void crossover(Chromosome parents[POPULATION_SIZE], Chromosome offspring[POPULATION_SIZE]) {
    // TODO: Implement a crossover method (e.g., single-point crossover, uniform crossover)

}

void mutation(Chromosome offspring[POPULATION_SIZE]) {
    // TODO: Implement a mutation method (e.g., bit-flip mutation, swap mutation)

}

int compare_fitness(const void *a, const void *b) {
    Chromosome *chromosome_a = (Chromosome *)a;
    Chromosome *chromosome_b = (Chromosome *)b;

    if (chromosome_a->fitness < chromosome_b->fitness) {
        return -1;
    } else if (chromosome_a->fitness > chromosome_b->fitness) {
        return 1;
    } else {
        return 0;
    }
}
