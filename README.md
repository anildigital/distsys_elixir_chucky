# Chucky

**TODO: Add description**

## Installation

```
mix deps.get
mix compile
```

## Run in distributed mode as 
```bash
iex --sname a -pa _build/dev/lib/chucky/ebin --app chucky --erl "-config config/a.config"
iex --sname b -pa _build/dev/lib/chucky/ebin --app chucky --erl "-config config/b.config"
iex --sname c -pa _build/dev/lib/chucky/ebin --app chucky --erl "-config config/c.config"
```
You can then run on any node.

```bash
iex(a@Alchemist)1> Chucky.fact
"Chuck Norris brushes his teeth with a mixture of iron shavings, industrial paint remover, and boner-grain alcohol."
```

See on which node application is started with following command

```bash
iex(a@Alchemist)1> Application.started_applications
```

Close the node a by pressing Ctrl+C twice and then see ```Application.started_applications``` on other nodes.
Failover should happen and one of the node starts the application.

Restart node a by executing 
```
iex --sname a -pa _build/dev/lib/chucky/ebin --app chucky --erl "-config config/a.config"
```
and it should takeover the application


