
unit module Data::Generators::RandomVariate;

#============================================================
# Distributions
#============================================================

class NormalDistribution is export {
    has Numeric $.mean = 0;
    has Numeric $.sd = 1;
}

class UniformDistribution is export {
    has Numeric $.min = 0;
    has Numeric $.max = 1;
}

#============================================================
# RandomVariate
#============================================================

#| Gives a pseudorandom variate from the distribution $dist.
our proto RandomVariate( $dist, UInt $size ) is export {*}

#------------------------------------------------------------
sub rnorm(Numeric $µ, Numeric $σ) {
    sqrt( -2 * log(rand)) * cos(2 * π * rand) * $σ + $µ;
}

multi RandomVariate($dist where $_ ~~ NormalDistribution, UInt $size --> List) {
    (rnorm($dist.mean, $dist.sd) xx $size).List
}

#------------------------------------------------------------
multi RandomVariate($dist where $_ ~~ UniformDistribution, UInt $size --> List) {
    (($dist.min..$dist.max).rand xx $size).List
}
