<cfparam name="attributes.aAdjacencyMatrix" default = "">
<cfparam name="attributes.r_aNodedata" default = "">
<cfparam name="attributes.r_lFinishOrder" default="">
<cfparam name="attributes.lOrder" default = "">
<cfparam name="attributes.r_aForest" default = "">


<cfset request.G = attributes.aAdjacencyMatrix>
<cfset request.nodedata = arraynew(1)>
<cfset request.counter = 1>
<cfset request.lFinishOrder = "">
<cfset request.aDFSForest = arraynew(1)>
<cfset request.ForestCounter = 1>

<cfloop from="1" to="#arraylen(request.G[1])#" index="i">
  <cfset request.nodedata[i] = structnew()>
  <cfset request.nodedata[i].marked = 0>
  <cfset request.nodedata[i].parent = 0>  
  <cfset request.nodedata[i].starttime = 0>
  <cfset request.nodedata[i].endtime = 0>    
  <cfset request.nodedata[i].lChildren = "">
</cfloop>
 
<cfif attributes.lOrder is "">
  <cfloop from="1" to="#arraylen(request.G[1])#" index="i">
    <cfif not request.nodedata[i].marked> 
      <cfset request.nodedata[i].parent = 0>
      <cfset request.nodedata[i].starttime = request.counter>
      <cfset request.counter = request.counter + 1>
      <cfset request.aDFSForest[request.ForestCounter] = "#i#">
      <cf_dfsrecurse vertex="#i#">
      <cfset request.ForestCounter = request.ForestCounter + 1>
      <cfset request.nodedata[i].endtime = request.counter>
      <cfset request.lFinishOrder = listappend(request.lFinishOrder,i)>
      <cfset request.counter = request.counter + 1>
    </cfif>
  </cfloop>

<cfelse>
  <cfloop list="#attributes.lOrder#" index="i">
    <cfif not request.nodedata[i].marked> 
      <cfset request.nodedata[i].parent = 0>
      <cfset request.nodedata[i].starttime = request.counter>
      <cfset request.counter = request.counter + 1>
      <cfset request.aDFSForest[request.ForestCounter] =  "#i#">
      <cf_dfsrecurse vertex="#i#">
      <cfset request.ForestCounter = request.ForestCounter + 1>
      <cfset request.nodedata[i].endtime = request.counter>
      <cfset request.lFinishOrder = listappend(request.lFinishOrder,i)>      
      <cfset request.counter = request.counter + 1>
    </cfif>
  </cfloop>
</cfif>
<cfset "caller.#attributes.r_aNodedata#" = request.nodedata>
<cfif attributes.r_lFinishorder is not "">
  <cfset "caller.#attributes.r_lFinishOrder#" = request.lFinishOrder>
</cfif>  

<cfset "caller.#attributes.r_aForest#" = request.aDFSForest>
