# TODOs


1. draw facet labels after geometries

1. make stats work

1. support tables as columns (for lines)

2. Support grouping and propogating mapped aesthetics down the
   workflow


1. allow aesthetics aliases

  color: "attr2"

  actually compiles to

  fill: "attr2"
  stroke: "attr2"


# DONE


x. make positioning work
x. make sure retraining scales after positioning works
   -> facets set position range in allocatePanes.  need to make sure if
      ranges are set that they will be used in future.
   -> stop overwriting existing scales objects?

