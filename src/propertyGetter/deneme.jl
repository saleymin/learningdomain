importall Base.SparseMatrix
import Base.SparseMatrix: increment, increment!, decrement, decrement!, nnz

versioninfo()

#ccall icin ve donusum icin 2 type.
#dfs'i yap
#dmperm yap


immutable cs
    nzmax::Cptrdiff_t
    m::Cptrdiff_t       #/* number of rows */
    n::Cptrdiff_t       #/* number of columns */
    p::Ptr{Cptrdiff_t}     #   /* column pointers (size n+1) or col indices (size nzmax) */
    i::Ptr{Cptrdiff_t}     #   /* row indices, size nzmax */
    x::Ptr{Cdouble}   #  /* numerical values, size nzmax */
    nz::Cptrdiff_t        ## of entries in triplet matrix, -1 for compressed-col */
end

immutable csd
    p::Ptr{Cptrdiff_t}
    q::Ptr{Cptrdiff_t}
    r::Ptr{Cptrdiff_t}
    s::Ptr{Cptrdiff_t}
    nb::Cptrdiff_t
    rr::Ptr{Cptrdiff_t}
    cc::Ptr{Cptrdiff_t}
end

cd("/disk2/home/suleyman/works/MatrixDownloader")

println("-------------");
println("ccall warm up");
println("pwd $( pwd() )")
libadd = Libdl.find_library(["libadd"]);
println("find lib $(libadd)")

t1 = ccall( (:hello,  "libadd") , Void, ( )  );  println();
t2 = ccall( (:add,  :libadd ) , Int, ( Int,Int, ), 15,1231  ); println(t2);


x = [10.0, 3, 3
     ,9,7,8,4
     ,8,2,9,2
     ,3,13, -1, 2
     ,1.2, -2
     ,5,3, 6

     ]
i = [  1,2,4
      ,2,3,5,6
      ,3,4,5,6
      ,2,5,6,3
      ,4,5
      ,1,3,4]
p = [1,4,8,12,16,18,20]

i = decrement(i);
p = decrement(p);

ptrp = pointer(p,1); # Instead define a convert method and pass the variables directly to the ccall.
ptri = pointer(i,1);
ptrx = pointer(x,1);

mat = cs(20,6,6, ptrp, ptri, ptrx ,-1 )

ptr = pointer_from_objref(mat);

mat = cs(20,6,6, ptrp, ptri, ptrx ,-1 )
ptr = pointer_from_objref(mat);
sccPtr = ccall( (:cs_scc,  :libcsparse ) , Ptr{csd}, ( Ptr{cs}, ), ptr )
scc =  unsafe_load (sccPtr)

println("$(typeof(sccPtr))");
println("$(typeof(scc))");

println("nb : $(scc.nb)");
