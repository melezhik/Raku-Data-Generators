# Raku Data::Generators

[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

This Raku package has functions for generating random strings, words, pet names, vectors, and
(tabular) datasets. 

### Motivation

The primary motivation for this package is to have simple, intuitively named functions
for generating random vectors (lists) and datasets of different objects.

Although, Raku has a fairly good support of random vector generation, it is assumed that commands
like the following are easier to use:

```{raku, eval = FALSE}
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```

------

## Random strings

The function `random-string` generates random strings.

Here we generate a vector of random strings with length 4 and characters that belong to specified ranges:

```raku
use Data::Generators;
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```
```
# ("115y", "y9Yn", "n7N9", "16YN", "1083", "58Y0")
```

------

## Random words

The function `random-word` generates random words.

Here we generate a list with 12 random words:

```raku
random-word(12)
```
```
# (service smooth-bodied Oniscidae scurf corkage commensally Lozal witchery convection chickweed hueless anthropometrical)
```

Here we generate a table of random words of different types:

```raku
use Data::Reshapers;
my @dfWords = do for <Any Common Known Stop> -> $wt { $wt => random-word(6, type => $wt) };
say to-pretty-table(@dfWords);
```
```
# +--------+------------+--------------+-----------+---------------+------------+---------------+
# |        |     2      |      3       |     0     |       5       |     4      |       1       |
# +--------+------------+--------------+-----------+---------------+------------+---------------+
# | Any    | Wykehamist |  euthanasia  |  Estronol | supplementary |    a.m.    |     tacit     |
# | Common |  stutter   | studiousness |   loggia  |    rhinitis   | roundabout | circumstances |
# | Known  |  Goldwyn   |  commotion   | Tocharian |     stolid    | doctorfish |     fulfil    |
# | Stop   |   how's    |   between    |     i     |     he'll     |   whole    |     hasn't    |
# +--------+------------+--------------+-----------+---------------+------------+---------------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

**Remark:** The function `to-pretty-table` is from the package 
[Data::Reshapers](https://modules.raku.org/dist/Data::Reshapers:cpan:ANTONOV).

------

## Random pet names

The function `random-pet-name` generates random pet names.

The pet names are taken from publicly available data of pet license registrations in
the years 2015–2020 in Seattle, WA, USA. See [DG1].

The following command generates a list of six random pet names:

```raku
srand(32);
random-pet-name(6).raku
```
```
# ("Margot", "Millie", "Roberta", "Tati", "Chewie", "Tati")
```

The named argument `species` can be used to specify specie of the random pet names. 
(According to the specie-name relationships in [DG1].)

Here we generate a table of random pet names of different species:

```raku
my @dfPetNames = do for <Any Cat Dog Goat Pig> -> $wt { $wt => random-pet-name(6, species => $wt) };
say to-pretty-table(@dfPetNames);
```
```
# +------+----------+------------------+-----------------------+----------+-----------+-----------+
# |      |    4     |        5         |           2           |    0     |     3     |     1     |
# +------+----------+------------------+-----------------------+----------+-----------+-----------+
# | Any  | Guinness | Sister Bertrille |        Roswell        |  Tanner  |  Guinness |  Atticus  |
# | Cat  | Nibbles  |       male       | The Little Muffin Man |   Ink    | Schmeeber | Safi-Sana |
# | Dog  |  Yummy   |      Abita       |         Sonoma        |  Peeve   |    Hook   |   Merfy   |
# | Goat |  Frosty  |       Arya       |         Pepina        |  Tacoma  |   Darcy   |   Piper   |
# | Pig  | Guinness |     Atticus      |        Guinness       | Guinness |  Atticus  |   Millie  |
# +------+----------+------------------+-----------------------+----------+-----------+-----------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

The named argument (adverb) `weighted` can be used to specify random pet name choice 
based on known real-life number of occurrences:

```raku
srand(32);
say ‌‌random-pet-name(6, :weighted).raku
```
```
# ("Tati", "Miss Scarlett", "Millie", "Professor Nibblesworth", "Atticus", "Atticus")
```

The weights used correspond to the counts from [DG1].

**Remark:** The implementation of `random-pet-name` is based on the Mathematica implementation
[`RandomPetName`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPetName),
[AAf1].

------

## Random pretentious job titles

The function `random-pretentious-job-title` generates random pretentious job titles.

The following command generates a list of six random pretentious job titles:

```raku
random-pretentious-job-title(6).raku
```
```
# ("International Paradigm Manager", "National Security Planner", "Forward Response Associate", "Global Marketing Executive", "Interactive Tactics Strategist", "Dynamic Marketing Representative")
```

The named argument `number-of-words` can be used to control the number of words in the generated job titles.

The named argument `language` can be used to control in which language the generated job titles are in.
At this point, only Bulgarian and English are supported.

Here we generate pretentious job titles using different languages and number of words per title:

```raku
my $res = random-pretentious-job-title(12, number-of-words => Whatever, language => Whatever);
say ‌‌to-pretty-table($res.rotor(3));
```
```
# +-------------------------------+-----------------------------------+---------------------------+
# |               0               |                 1                 |             2             |
# +-------------------------------+-----------------------------------+---------------------------+
# | Областен Асистент на Интранет | Вътрешен Консултант на Показатели |    Lead Group Designer    |
# |        Data Coordinator       |               Техник              | Старши Проектант по Екипи |
# |   Lead Security Coordinator   |             Synergist             |   Стратег по Комуникации  |
# |           Проектант           |   Национален Инженер по Фактори   |          Дизайнер         |
# +-------------------------------+-----------------------------------+---------------------------+
```

**Remark:** `Whatever` can be used as values for the named arguments `number-of-words` and `language`.

**Remark:** The implementation uses the job title phrases in https://www.bullshitjob.com . 
It is, more-or-less, based on the Mathematica implementation 
[`RandomPretentiousJobTitle`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPretentiousJobTitle),
[AAf2].

------

## Random reals

This module provides the function `random-variate` that can be used to generate lists of real numbers
using distribution specifications.

Here are examples:

```raku
say random-variate(NormalDistribution.new(:mean(10), :sd(20)), 5); 
```
```
# (-18.615180334983382 -14.777307898313193 11.744540271606233 32.83415351542184 23.05439201645865)
```

```raku
say random-variate(NormalDistribution.new( µ => 10, σ => 20), 5); 
```
```
# (35.82804554696579 -12.643547444336193 16.320377789979375 27.16893715675326 14.117125819449708)
```

```raku
say random-variate(UniformDistribution.new(:min(2), :max(60)), 5);
```
```
# (27.66534628863628 15.022852723841478 41.15611113824118 54.085283581723125 57.46240753137406)
```

**Remark:** Only Normal distribution and Uniform distribution are implemented at this point.

**Remark:** The signature design follows Mathematica's function 
[`RandomVariate`](https://reference.wolfram.com/language/ref/RandomVariate.html).

Here is an example of 2D array generation:

```raku
say random-variate(NormalDistribution.new, [3,4]);
```
```
# [[-0.4479067963939533 0.28167926816285005 -1.075347558796815 1.3360794891272738]
#  [1.4424534618996863 -1.0817181852485276 1.1124463316112607 0.8958722847013001]
#  [0.9971898647548 0.5300761587505801 -0.19123738083454592 -0.04397620670389424]]
```

------

## Random tabular datasets

The function `random-tabular-dataset` can be used generate tabular *datasets*.

**Remark:** In this module a *dataset* is (usually) an array of arrays of pairs.
The dataset data structure resembles closely Mathematica's data structure 
[`Dataset`]https://reference.wolfram.com/language/ref/Dataset.html), [WRI2]. 

**Remark:** The programming languages R and S have a data structure called "data frame" that
corresponds to dataset. (In the Python world the package `pandas` provides data frames.)
Data frames, though, are column-centric, not row-centric as datasets.
For example, data frames do not allow a column to have elements of heterogeneous types.

Here are basic calls:

```{perl6, eval=FALSE}
random-tabular-dataset();
random-tabular-dataset(Whatever):row-names;
random-tabular-dataset(Whatever, Whatever);
random-tabular-dataset(12, 4);
random-tabular-dataset(Whatever, 4);
random-tabular-dataset(Whatever, <Col1 Col2 Col3>):!row-names;
```

Here is example of a generated tabular dataset that column names that are cat pet names:

```raku
my @dfRand = random-tabular-dataset(5, 3, column-names-generator => { random-pet-name($_, species => 'Cat') });
say to-pretty-table(@dfRand);
```
```
# +----------+--------------------+----------------+
# |  Winton  |      Liliquoi      |    Cheddar     |
# +----------+--------------------+----------------+
# |  Praia   | 19.859813619203255 |    musingly    |
# | schlock  | 21.238698325857193 |    prudery     |
# |  Dacca   | 21.52325074237404  | oleaginousness |
# |  drably  | 22.069553581961273 |   underside    |
# | complain | 12.188987647044241 |  latticework   |
# +----------+--------------------+----------------+
```

The display function `to-pretty-table` is from
[`Data::Reshapers`](https://modules.raku.org/dist/Data::Reshapers:cpan:ANTONOV).

**Remark:** At this point only
[*wide format*](https://en.wikipedia.org/wiki/Wide_and_narrow_data)
datasets are generated. (The long format implementation is high in my TOOD list.)

**Remark:** The signature design and implementation are based on the Mathematica implementation
[`RandomTabularDataset`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomTabularDataset),
[AAf3].

------

## TODO

1. [ ] Random tabular datasets generation
    - [X] Row spec
    - [X] Column spec that takes columns count and column names
    - [X] Column names generator
    - [X] Wide form implementation only
    - [X] Generators of column values  
      - [X] Column-generator hash
      - [X] List of generators
      - [X] Single generator
      - [X] Turn "generators" that are lists into sampling pure functions
    - [ ] Long form implementation
    - [ ] Max number of values
    - [ ] Min number of values
    - [ ] Form (long or wide)
    - [X] Row names (automatic)
    
2. [X] Random reals vectors generation

3. [ ] Figuring out how to handle and indicate missing values
   
4. [ ] Random reals vectors generation according to distribution specs
    - [X] Uniform distribution
    - [X] Normal distribution
    - [ ] Poisson distribution
    - [ ] Skew-normal distribution
    - [ ] Triangular distribution

5. [ ] Selection between `roll` and `pick` for:
    - [ ] `RandomWord`  
    - [ ] `RandomPetName`

------

## References

### Articles

[AA1] Anton Antonov,
["Pets licensing data analysis"](https://mathematicaforprediction.wordpress.com/2020/01/20/pets-licensing-data-analysis/), 
(2020), 
[MathematicaForPrediction at WordPress](https://mathematicaforprediction.wordpress.com).

### Functions, packages

[AAf1] Anton Antonov,
[RandomPetName](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPetName),
(2021),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository).

[AAf2] Anton Antonov,
[RandomPretentiousJobTitle](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPretentiousJobTitle),
(2021),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository).

[AAf3] Anton Antonov,
[RandomTabularDataset](https://resources.wolframcloud.com/FunctionRepository/resources/RandomTabularDataset),
(2021),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository).

[SHf1] Sander Huisman,
[RandomString](https://resources.wolframcloud.com/FunctionRepository/resources/RandomString),
(2021),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository).

[WRI1] Wolfram Research (2010), 
[RandomVariate](https://reference.wolfram.com/language/ref/RandomVariate.html), 
Wolfram Language function.

[WRI2] Wolfram Research (2014),
[Dataset](https://reference.wolfram.com/language/ref/Dataset.html),
Wolfram Language function.

### Data repositories

[DG1] Data.Gov,
[Seattle Pet Licenses](https://catalog.data.gov/dataset/seattle-pet-licenses),
[catalog.data.gov](https://catalog.data.gov).
