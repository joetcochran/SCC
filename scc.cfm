<!---
         Author:         Joe Cochran (joetcochran@yahoo.com)
         FileName:       scc
         Purpose:        This tag computes strongly connected components of an
                          Adjacency Matrix. This can be used to answer the question of
         Input:          An adjcacency matrix, or parameters with which to create randomly an
                         adjacency matrix
         Output:         r_aSCCs : An array of lists, where each array element is a strongly connected component,
                                   with each list item being a node that helps make up that strongly connected component

         Attributes:      bCreateAdjacencyMatrix {yes|no}: Indicates if you want the custom tag to randomly generate a
                                                            adjacency matrix for you. 
                          aAdjacencyMatrix : A 2D array with as many rows as columns. This matrix represents the edges
                                            of the graph. A '1' indicates that a direct path exists from the row # to
                                            the column #. A '0' indicates that no such direct path exists.
                          nNodes: Required if bCreateAdjacencyMatrix is "yes". Specifies how many nodes are in your graph
                          nEdgeDensity: Required if bCreateAdjacencyMatrix is "yes". Specifies the density (how many edges)
                                        your graph has. This number should be expressed between 0 and 1. The final
                                        number of edges of the created matrix will be (nNodes * nNodes) *nEdgeDensity
                          bShowAdjcacencyMatirx {yes|no} : Specifies whether you want the custom tag to display the
                                                           input matriz
                          r_aAdjacencyMatrixDFS: Array which indicates the depth-first-search forest of the input
                                                  Adjacency Matrix. Each array element is a struct with the following
                                                  keys: MARKED, PARENT, STARTTIME, ENDTIME, LCHILDREN
                          bShowTransposeMatrix {yes|no}: Specifies whether you want the custom tag to display the 
                                                         transpose of the input Adjacency Matrix.
                          r_aTransposeMatrixDFS: Array which indicated the depth-first-search forest of the transposed matrix.
                                                  Each array element is a struct with the following keys: MARKED, PARENT, 
                                                  STARTTIME, ENDTIME, LCHILDREN
                          r_aSCCs: Array of the strongly connected components in the graph. There exists a path from 
                                    each node in an array element to another node in the array element, and back to
                                    the original one.
         Example:         <cf_scc 
                           bCreateAdjacencyMatrix = "Yes"
                           nNodes = "20"
                           nEdgeDensity = ".10"
                           bShowAdjacencyMatrix = "Yes"
                           r_aAdjacencyMatrixDFS = "aFirstDFS"
                           bShowTransposeMatrix = "Yes"
                           r_aTransposeMatrixDFS = "aSecondDFS"
                           r_aSCCs = "aStronglyConnectedComponents">
                           
         NOTES: For more information on the Strongly Connected Components algorithm, please visit
                http://x86.cs.duke.edu/~mlittman/courses/Archive/cps130-97/lectures/lect16/node14.html
                http://www.daimi.aau.dk/~hrn/COURSES/CourseS99/CFA2/sld001.htm
                http://www.almaden.ibm.com/cs/k53/www9.final/
                
         
         
         Modification Log:
         ----------  ------------------  ----------------------------------
         Date        Author              Modification
         ----------  ------------------  ----------------------------------
		     8-26-2000	   Joe Cochran		     Created
--->
<cfparam name="attributes.bCreateAdjacencyMatrix" default="yes">
<cfparam name="attributes.aAdjacencyMatrix" default="">
<cfparam name="attributes.nNodes" default="1">
<cfparam name="attributes.nEdgeDensity" default="1">
<cfparam name="attributes.bShowAdjacencyMatrix" default="no">
<cfparam name="attributes.r_aAdjacencyMatrixDFS" default="">
<cfparam name="attributes.bShowTransposeMatrix" default="no">
<cfparam name="attributes.r_aTransposeMatrixDFS" default="">
<cfparam name="attributes.r_aSCCs" default = "">

<cfif attributes.bCreateAdjacencyMatrix>
  <cf_createadjacencymatrix
   nodes="#attributes.nNodes#"
   edgedensity="#attributes.nEdgeDensity#"
   r_aMatrix="thematrix">
<cfelse>
  <cfset thematrix = attributes.aAdjacencyMatrix>
</cfif>
  
<cfif attributes.bShowAdjacencyMatrix>
 <cf_show2darray
 array="#thematrix#"> 
</cfif>
 
 <cf_dfs
  aAdjacencyMatrix="#thematrix#"
  r_aNodedata = "aNodedata"
  r_lFinishOrder = "lFinishOrder"
  r_aForest = "aForest">
  
 <cfif len(attributes.r_aAdjacencyMatrixDFS)>
  <cfset "caller.#attributes.r_aAdjacencyMatrixDFS#" = aNodeData>
 </cfif>
 
 <cfset lDecFinishOrder = "">
 <cfset aFinishOrder = listtoarray(lFinishOrder)>
 <cfloop from="#arraylen(aFinishOrder)#" to="1" step="-1" index="i">
    <cfset lDecFinishOrder = listappend(lDecFinishOrder,aFinishOrder[i])>
 </cfloop> 

 <cf_transposematrix
  input = "#thematrix#"
  output="transpose">

  <cfif attributes.bShowTransposeMatrix>
   <cf_show2darray
   array="#transpose#"> 
  </cfif>
    
  
 <cf_dfs
  aAdjacencyMatrix="#transpose#"
  lOrder="#lDecFinishOrder#"
  r_aNodedata="aSCCs"
  r_aForest="aSCCForest">

 <cfif len(attributes.r_aTransposeMatrixDFS)>
  <cfset "caller.#attributes.r_aTransposeMatrixDFS#" = aSCCs>
 </cfif>

  
<cfset "caller.#attributes.r_aSCCs#" = aSCCForest>
