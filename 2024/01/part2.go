package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	b, err := os.ReadFile("input.txt")
	if err != nil {
		log.Fatal(err)
	}

	lines := strings.Split(string(b), "\n")

	nums := make([]string, 0)

	for i := range lines {
		for _, element := range strings.Split(lines[i], "   ") {
			nums = append(nums, element)
		}
	}

	half := len(nums) / 2

	lefts := make([]int, half)
	rights := make([]int, half)

	for i := 0; i < half; i++ {
		lefts[i], err = strconv.Atoi(nums[i*2])
		if err != nil {
			log.Fatal(err)
		}
		rights[i], err = strconv.Atoi(nums[(i*2)+1])
		if err != nil {
			log.Fatal(err)
		}
	}

	// sort.Slice(lefts, func(i, j int) bool {
	// 	return lefts[i] < lefts[j]
	// })

	// sort.Slice(rights, func(i, j int) bool {
	// 	return rights[i] < rights[j]
	// })

	rollingTotal := 0

	for i := 0; i < half; i++ {
		total := 0

		for j := 0; j < half; j++ {
			if lefts[i] == rights[j] {
				total++
			}
		}

		fmt.Println(lefts[i]*total, lefts[i], total)

		rollingTotal += lefts[i] * total
	}
	fmt.Println(lefts)
	fmt.Println(rights)
	fmt.Println(nums)

	fmt.Println(rollingTotal)
}
