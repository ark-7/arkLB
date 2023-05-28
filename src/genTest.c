#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "genetic_algorithm.h"

// Test function for initializing a population
void test_initialize_population() {
    int population_size = 10;
    int sequence_length = 5;
    char character_set[] = "abcdefghijklmnopqrstuvwxyz";
    Population* population = initialize_population(population_size, sequence_length, character_set);
    // Check that the population was initialized with the correct size
    assert(population->size == population_size);
    // Check that each individual in the population was initialized with the correct sequence length
    for (int i = 0; i < population_size; i++) {
        assert(strlen(population->individuals[i]->sequence) == sequence_length);
    }
    // Check that each character in the sequence is in the character set
    for (int i = 0; i < population_size; i++) {
        for (int j = 0; j < sequence_length; j++) {
            assert(strchr(character_set, population->individuals[i]->sequence[j]) != NULL);
        }
    }
    free_population(population);
}

// Test function for calculating the fitness of an individual
void test_calculate_fitness() {
    char sequence[] = "hello";
    char priority[] = "lehxo";
    int fitness = calculate_fitness(sequence, priority);
    // Check that the fitness was calculated correctly
    assert(fitness == 5);
}

// Test function for selecting a parent using tournament selection
void test_tournament_selection() {
    int population_size = 10;
    int sequence_length = 5;
    char character_set[] = "abcdefghijklmnopqrstuvwxyz";
    Population* population = initialize_population(population_size, sequence_length, character_set);
    int parent_index = tournament_selection(population);
    // Check that the parent index is within the range of the population size
    assert(parent_index >= 0 && parent_index < population_size);
    free_population(population);
}

// Test function for performing single-point crossover on two parents
void test_single_point_crossover() {
    char parent1[] = "hello";
    char parent2[] = "world";
    char* child1 = (char*) malloc(sizeof(char) * (strlen(parent1) + 1));
    char* child2 = (char*) malloc(sizeof(char) * (strlen(parent2) + 1));
    single_point_crossover(parent1, parent2, child1, child2);
    // Check that the children were created correctly
    assert(strcmp(child1, "helld") == 0);
    assert(strcmp(child2, "worlo") == 0);
    free(child1);
    free(child2);
}

// Test function for performing swap mutation on an individual
void test_swap_mutation() {
    char sequence[] = "hello";
    char character_set[] = "abcdefghijklmnopqrstuvwxyz";
    swap_mutation(sequence, character_set);
    // Check that the mutation occurred
    assert(strcmp(sequence, "hlelo") != 0);
}

// Test function for running the genetic algorithm
void test_genetic_algorithm() {
    int population_size = 10;
    int sequence_length = 5;
    char character_set[] = "abcdefghijklmnopqrstuvwxyz";
    char priority[] = "lehxo";
    int max_generations = 100;
    Population* population = initialize_population(population_size, sequence_length, character_set);
    Individual* best_individual = genetic_algorithm(population, priority, max_generations);
    // Check that the best individual was found
    assert(best_individual != NULL);
    // Check that the best individual has the correct fitness
    assert(best_individual->fitness == strlen(priority));
    free_population(population);
}

int main() {
    // Seed the random number generator
    srand(time(NULL));
    // Run the unit tests
    test_initialize_population();
    test_calculate_fitness();
    test_tournament_selection();
    test_single_point_crossover();
    test_swap_mutation();
    test_genetic_algorithm();
    printf("All unit tests passed!\n");
    return 0;
}