import "@typespec/http";
import "@typespec/openapi";

import "./models";
import "./routes";

using Http;
using OpenAPI;

@info(#{
  version: "1.22",
  license: #{ name: "Apache 2.0", url: "http://www.apache.org/licenses/LICENSE-2.0.html" },
})
@service(#{ title: "NEM NIS API Endpoints" })
@doc("OpenAPI Specification of NEM NIS API")
@server("http://localhost:3000", "Local development")
@server("http://libertalia.nemtest.net:7890", "libertalia")
@server("http://ocracoke.nemtest.net:7890", "ocracoke")
@server("http://tortuga.nemtest.net:7890", "tortuga")
@server("http://ntn1.dusanjp.com:7890", "nis1testnet-1a")
@server("http://ntn2.dusanjp.com:7890", "nis1testnet-2a")
namespace Nem;
