# omnisharp

## How to use Omnisharp Mono

The `omnisharp` server will use the `dotnet` (NET6) runtime to run the server. To run the server using the Mono runtime,
use the `omnisharp_mono` server instead (**this requires the `omnisharp-mono` package to be installed**).

**Note:** The `omnisharp_mono` server configuration doesn't exist in `lspconfig` but is provided by `mason-lspconfig`.
This is done in order to separate the .NET and Mono variants, making both easily accessible.

```lua
local lspconfig = require "lspconfig"

lspconfig.omnisharp_mono.setup {}
```
