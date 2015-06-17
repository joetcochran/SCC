<cfparam name="attributes.vertex" default = "1">

<cfset v = attributes.vertex>
<cfset request.nodedata[v].marked = 1>
<cfset p = structnew()>
<cfset p = request.G[v]>

<cfloop from="1" to="#arraylen(request.G[1])#" index="nthEdge">
<cfif request.G[v][nthEdge]>
  <cfif not request.nodedata[nthEdge].marked>
    <cfset request.nodedata[nthEdge].marked = 1>
    <cfset request.nodedata[nthEdge].parent = v>
    <cfset request.nodedata[nthEdge].starttime = request.counter>
    <cfset request.nodedata[v].lChildren = listappend(request.nodedata[v].lChildren,nthEdge)>
    <cfset request.counter = request.counter + 1>
    <cfset request.aDFSForest[request.ForestCounter] = listappend(request.aDFSForest[request.ForestCounter], "#nthEdge#")>
    <cf_dfsrecurse vertex="#nthEdge#">
    <cfset request.nodedata[nthEdge].endtime = request.counter>
    <cfset request.lFinishOrder = listappend(request.lFinishOrder,nthEdge)>          
    <cfset request.counter = request.counter + 1>
  </cfif>
</cfif>
 
</cfloop>

