brisket Cookbook
================
This cookbook installs everything required to build and run a brisket node on Ubuntu 13.10 x64.

Usage
-----
#### brisket::default

e.g.
Just include `brisket` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[brisket]"
  ]
}
```