<cfparam name="attributes.array" default="">

 <cfoutput>
 <table width="100%">
 <cfloop from="1" to="#arraylen(attributes.array[1])#" index="i">
  <cfif i is 1>
    <tr><td></td><cfloop from="1" to="#arraylen(attributes.array[1])#" index="l"><td>#l#</td></cfloop></tr>
  </cfif>
  <tr><td>#i#</td>
  <cfloop from="1" to="#arraylen(attributes.array[1])#" index="j">
    <td>#attributes.array[i][j]#</td>
  </cfloop>
  </tr>
 </cfloop>
 </table>
 </cfoutput> 