# Advent of Code 2023 using Dart 3.2

![](https://img.shields.io/badge/day%20📅-1-blue)![](https://img.shields.io/badge/days%20completed-1-red)![](https://img.shields.io/badge/stars%20⭐-2-yellow)

Initially I had in mind to go with Rust, but I does not feel like my language yet. Therefore I go with Dart again as I did 2022.

The template is based on the idea of https://github.com/S-ecki/AdventOfCode-Starter-Dart.

<!--- advent_readme_stars table --->
## 2023 Results

| Day | Part 1 | Part 2 |
| :---: | :---: | :---: |
| [Day 1](https://adventofcode.com/2023/day/1) | ⭐ | ⭐ |
<!--- advent_readme_stars table --->

## Diary

### Day 01

PartA was pretty simple to solve with a RegEx. For the second part I used the `matchAny` function of the `quiver` library, which allows to match against a list of patters. It was quite some typing to get all the patterns covered. I had some copy past error where I tried to parse the int from a number as a word. I forgot to change matchLast to matchFirst after copy. Let's see what tomorrow brings. Maybe I will take some time to clean up.

### Day 02

Today I tried out the dartx package to parse into integers and I used a lot of splitting on the specific delimiters. I also created and enum for the colors and s simple `ColorCounts` class to hold the values. The List comprehension in the end was done using `.map` on the List of `ColorCounts`. In Python it feels a bit better and the types did not allow me to have it all in one line. A special thanks goes to the `trim()` method today.