#<< gg/wf/node


#
# Add group pair into the environment.  Abstractly:
#
#   env.push {key: val}
#
# used by first xform in layer to name the rest of the workflow
#
# spec.key  label name e.g., "layer"
# spec.val  label value e.g., "layer-2"
#           also: spec.value
# spec.f    function to dynamically compute label value
#
class gg.wf.EnvPush extends gg.wf.Node
  constructor: (@spec={}) ->
    super @spec
    @type = "label"
    @name = _.findGood [@spec.name, "#{@type}-#{@id}"]
    @log = gg.util.Log.logger @name

    @params.ensureAll
      compute: [ ['val', 'value', 'f'], null ]

    unless @params.get('key')?
      throw Error("#{@name}: Need label key and value/value function)")


  run: ->
    throw Error("#{@name}: node not ready") unless @ready()

    data = @inputs[0]
    compute = @params.get 'compute'
    key = @params.get 'key'
    if _.isFunction compute
      val = compute data.table, data.env, @params
    else
      val = compute

    @log "adding label #{key} -> #{val}"

    env = data.env.clone()
    env.put key, val
    @output 0, new gg.wf.Data(data.table, env)
    data.table


#
# Copy a key from the environment into a column in table
# Abstractly:
#
#   table.addColumn attr, env.get(key)
#
# used to bring group-by attributes back into table
#
# spec.envkey  label name e.g., "layerIdx"
# spec.attr    new table attribute's name e.g., "fill"
# spec.default value if envkey not found.
#              set to null if don't add if envkey not found.
#
class gg.wf.EnvGet extends gg.wf.Node
  constructor: (@spec={}) ->
    super @spec
    @type = "envget"
    @name = _.findGood [@spec.name, "#{@type}-#{@id}"]

    @params.ensureAll
      envkey: [ ['key', 'envkey'] ]
      attr: ['attr', 'key', 'envkey']
      default: [[], null]

    unless @params.get('envkey')?
      throw Error("#{@name}: Need label key and value/value function)")

  run: ->
    throw Error("#{@name}: node not ready") unless @ready()

    data = @inputs[0]
    table = data.table.clone()

    envkey = @params.get 'envkey'
    defaultVal = @params.get 'default'
    attr = @params.get 'attr'

    unless envkey? and data.env.contains envkey
      @output 0, @inputs[0]
      return

    val = data.env.get envkey, defaultVal
    table.addConstColumn attr, val

    @output 0, new gg.wf.Data table, data.env.clone()
    table


