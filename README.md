# Advent of Code 2023 using Dart 3.2

![](https://img.shields.io/badge/day%20📅-11-blue)![](https://img.shields.io/badge/days%20completed-11-red)![](https://img.shields.io/badge/stars%20⭐-22-yellow)

Initially I had in mind to go with Rust, but I does not feel like my language yet. Therefore I go with Dart again as I did 2022.

The template is based on the idea of https://github.com/S-ecki/AdventOfCode-Starter-Dart.

<!--- advent_readme_stars table --->
## 2023 Results

| Day | Part 1 | Part 2 |
| :---: | :---: | :---: |
| [Day 1](https://adventofcode.com/2023/day/1) | ⭐ | ⭐ |
| [Day 2](https://adventofcode.com/2023/day/2) | ⭐ | ⭐ |
| [Day 3](https://adventofcode.com/2023/day/3) | ⭐ | ⭐ |
| [Day 4](https://adventofcode.com/2023/day/4) | ⭐ | ⭐ |
| [Day 5](https://adventofcode.com/2023/day/5) | ⭐ | ⭐ |
| [Day 6](https://adventofcode.com/2023/day/6) | ⭐ | ⭐ |
| [Day 7](https://adventofcode.com/2023/day/7) | ⭐ | ⭐ |
| [Day 8](https://adventofcode.com/2023/day/8) | ⭐ | ⭐ |
| [Day 9](https://adventofcode.com/2023/day/9) | ⭐ | ⭐ |
| [Day 10](https://adventofcode.com/2023/day/10) | ⭐ | ⭐ |
| [Day 11](https://adventofcode.com/2023/day/11) | ⭐ | ⭐ |
<!--- advent_readme_stars table --->

## Diary

### Day 01

PartA was pretty simple to solve with a RegEx. For the second part I used the `matchAny` function of the `quiver` library, which allows to match against a list of patters. It was quite some typing to get all the patterns covered. I had some copy past error where I tried to parse the int from a number as a word. I forgot to change matchLast to matchFirst after copy. Let's see what tomorrow brings. Maybe I will take some time to clean up.

### Day 02

Today I tried out the dartx package to parse into integers and I used a lot of splitting on the specific delimiters. I also created and enum for the colors and s simple `ColorCounts` class to hold the values. The List comprehension in the end was done using `.map` on the List of `ColorCounts`. In Python it feels a bit better and the types did not allow me to have it all in one line. A special thanks goes to the `trim()` method today.

### Day 03

Today was fun. My initial idea was to go with the Symbols and check the neighbours their, but I found it pretty hard to get the correct numbers. So I started to get the numbers first and checked the neighbours of the first and the end position of the number. I was able to reuse the `Field` in the template repository to get the neighbours.
I also had the idea of extracting the symbols from the input instead of writing a list of all possible symbols, I was sure that I would have missed one of the symbols.

### Day 04

Today was straight forward. I had some trouble with spaces in my splits, but that was fixed easily. I hopefully finally remember the `fold` for getting a sum of the values of a list.

### Day 05

This was brute-force 10 Minutes on my machine. I probably come back to this one, when there is time.

### Day 06

Also brute force in the first, but then I used the `equations` package and the time went from som 300 ms to about 1 ms. This was nice.

### Day 07

That was some headache. My compareTo function wasn't working in the beginning for Part 2, because I did not check on the source hand, but on the hand with my replaced values.

### Day 08

That was a cool riddle. Part 1 was straight forward. Part 2 could not be solved simulating, but with the LCM for all cycles found for each start.

### Day 09

Today was rather easy, but I had some issues with negative values in my predictions.

### Day 10

The first part was okay, but I forgot a few things. Like "S" as a possible connected pipe. The Part 2 was solved by shoelace and pick's theory. Thank you AoC community for this hint.

### Day 11

Cool riddle today. It was actaully straight forward, but it was a bit of typing and I made some errors in the initial expansion. For part to I got a headeache because of `extensionFactor - 1`. But now it solves. I hope no one tried brute-forcing it.

### Day 15

THis was easy doing today. You just need to read carefully. I forgot to read the fact, that the relevant box is just on the label and not the entire instruction. Also the 0 index based list calucaltion for the focal power was missing a `+1`, multiplication by 0 does not bring up high values :-D. 