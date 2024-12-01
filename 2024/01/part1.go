package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"sort"
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

	half := len(nums)

	lefts := make([]int, half)
	rights := make([]int, half)

	for i := 0; i < half; i += 2 {
		lefts[i], err = strconv.Atoi(nums[i])
		if err != nil {
			log.Fatal(err)
		}
		rights[i], err = strconv.Atoi(nums[i+1])
		if err != nil {
			log.Fatal(err)
		}
	}

	sort.Slice(lefts, func(i, j int) bool {
		return lefts[i] < lefts[j]
	})

	sort.Slice(rights, func(i, j int) bool {
		return rights[i] < rights[j]
	})

	total := 0

	for i := 0; i < half; i++ {
		fmt.Print(lefts[i], " ", rights[i], "\n")
		total += int(math.Abs(float64(lefts[i] - rights[i])))
	}

	fmt.Print(total)
}
