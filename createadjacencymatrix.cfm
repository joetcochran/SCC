<cfparam name="attributes.nodes" default="0">
<cfparam name="attributes.edgedensity" default="0">
<cfparam name="attributes.r_aMatrix" default = "">


<cfset edges=int(evaluate(attributes.nodes * attributes.nodes * attributes.edgedensity))>

<cfset aAdjacencymatrix = arraynew(2)>

<cfloop from="1" to="#attributes.nodes#" index="i">
  <cfloop from="1" to="#attributes.nodes#" index="j">
    <cfset aAdjacencyMatrix[i][j] = 0>
  </cfloop>
</cfloop>

<cfset counter="0">
<cfloop condition="counter LESS THAN OR EQUAL TO edges">
  <cfset random1 = randrange(1,attributes.nodes)>
  <cfset random2 = randrange(1,attributes.nodes)>
  
  <cfif aAdjacencymatrix[random1][random2] is 0>
    <cfset aAdjacencymatrix[random1][random2] = 1>
    <cfset counter = counter + 1>
  </cfif>    
</cfloop>
 

<cfset "caller.#attributes.r_aMatrix#" = aAdjacencyMatrix>

