#<< gg/scale/categorical

class gg.scale.Ordinal extends gg.scale.BaseCategorical
  @ggpackage = 'gg.scale.Ordinal'
  @aliases = ['ordinal', 'categorical']

  scale: (v) ->
    res = super
    res + @d3Scale.rangeBand()/2.0


