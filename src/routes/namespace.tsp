import "../types/core.tsp";
import "../models";

using Http;
using OpenAPI;

@tag("namespace")
@route("/namespace")
namespace Nem.Namespace {
  @get
  @route("/roots")
  @summary("Retrieving root namespaces")
  @doc("Retrieves a list of root namespaces, optionally paginated.")
  @operationId("getNamespaceRoots")
  op getNamespaceRoots(
    @query(#{ explode: true }) id?: integer,
    @query(#{ explode: true }) pageSize?: integer,
  ): Body<NamespaceMetaDataPair[]>;

  @get
  @summary("Retrieving a specific namespace")
  @doc("Retrieves details of a specific namespace by its name.")
  @operationId("getNamespace")
  op getNamespace(@query(#{ explode: true }) `namespace`?: string): Body<NamespaceDTO>;

  @get
  @route("/mosaic/definition/page")
  @summary("Retrieving mosaic definitions")
  @doc("Retrieves mosaic definitions associated with a given namespace.")
  @operationId("getNamespaceMosaicDefinitions")
  op getNamespaceMosaicDefinitions(@query(#{ explode: true }) `namespace`?: string): Body<MosaicDefinitionMetaDataPair[]>;
}
