<cfparam name="attributes.input" default = "">
<cfparam name="attributes.output" default = "">

<cfset transpose = arraynew(2)>
<cfset transpose = attributes.input>

<cfloop from="1" to="#arraylen(attributes.input[1])#" index="i">
  <cfloop from="1" to="#arraylen(attributes.input[1])#" index="j">
    <cfset transpose[i][j] = attributes.input[j][i]>
  </cfloop>
</cfloop>
 
<cfset "caller.#attributes.output#" = transpose>
