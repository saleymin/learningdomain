 
function  findNumberOfStronglyConnectedComponents2(M::MatrixProperty)
  M.isSymmectric = issym(M.mm.matrix);
  M.isSquare = isequal(M.numberOfRows, M.numberOfColumns );

 maxComponent = 0;
  if M.isSquare #graph
        visited = Array(Bool, M.numberOfRows)
        seen = Array(Bool, M.numberOfRows)
        for i=1:M.numberOfRows
          visited[i] =false;
          seen[i] =false;
        end
       while (any(visited .== false))
          minIdx =  findfirst(visited .== false)
          DFSSearch(minIdx, M, visited,seen,0);
          maxComponent = maxComponent + 1;
       end
  end

  M.numberOfConnectedComponent2 = maxComponent;
  return M.numberOfConnectedComponent2


  #M.NumberOfConnectedComponent = maxComponent;
  #return maxComponent
end

function DFSSearch(currentNode::Int , M::MatrixProperty, visited::Array{Bool,1}, seen::Array{Bool,1},  depth::Int)
        #array uzerinden aramak yerine daha performansli bir yol gerekiyor.

        visited[currentNode] = true;
        v = find(M.mm.matrix[:, currentNode ]);
        nextNodes = v[ find( x->(seen[x] == false),  v) ];
        seen[nextNodes] = true;

        for i in nextNodes
          if( visited[i] == false )
              DFSSearch(i, M, visited,seen, depth+1)
          end
        end
end



