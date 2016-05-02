type mmStructure
    domain :: AbstractString;
    representation :: AbstractString;
    field :: AbstractString;
    symmetric :: AbstractString;
    matrix:: SparseMatrixCSC;
end


function mmread(filename::ASCIIString, infoonly::Bool)
#      Reads the contents of the Matrix Market file 'filename'
#      into a matrix, which will be either sparse or dense,
#      depending on the Matrix Market format indicated by
#      'coordinate' (coordinate sparse storage), or
#      'array' (dense array storage).  The data will be duplicated
#      as appropriate if symmetry is indicated in the header. (Not yet
#      implemented).
#
#      If infoonly is true information on the size and structure is
#      returned.

    mmfile = open(filename,"r")
    tokens = split(chomp(readline(mmfile)))
	domain = "";
    if length(tokens) != 5 error("Not enough words on header line") end
    if tokens[1] != "%%MatrixMarket" error("Not a valid MatrixMarket header.") end
    (head1, rep, field, symm) = map(lowercase, tokens[2:5])

	#println("head1: $(head1)");
	#println("rep: $(rep)");
	#println("field: $(field)");
	#println("symm: $(symm)");

    if head1 != "matrix"
        error("This seems to be a MatrixMarket $head1 file, not a MatrixMarket matrix file")
    end
    
	if field != "real"  && field != "complex" && field != "integer"  && field != "pattern" 
		throw(ParseError("non-float fields not yet allowed")) 
	end

    ll   = readline(mmfile)         # Read through comments, ignoring them

    while length(ll) > 0 && ll[1] == '%' 
		
		ll = readline(mmfile) 
		splitarr  = 	 split(ll, ':');
		if( length( splitarr ) == 2)
			if( strip( strip( splitarr[1], '%'), ' ') == "kind")
				domain = strip( splitarr[2] );
			end
		end
	end

    dd     =  map( x-> parse(Int,x) , (split(ll)))        # Read dimension
    rows   = dd[1]
    cols   = dd[2]
    entries = rep == "coordinate" ?  dd[3]       : rows * cols
    entries = symm == "symmetric" ?  2 * entries : entries;

    if infoonly return rows, cols, entries, rep, field, symm end
    if rep == "coordinate"
        rr = Array(Int, entries)
        cc = Array(Int, entries)
    	if( field == "complex")
		   xx = Array( Complex{Float64}, entries)	
		else  
		   xx = Array(Float64, entries)	
		end
		i = 1;

        while i <= entries
            flds = split(readline(mmfile))
            rr[i] = parse(Int, flds[1])
            cc[i] = parse(Int, flds[2])
            if(field == "real" || field == "integer")
              xx[i] = parse(Float64, flds[3])
            elseif(field == "pattern")
              xx[i] = 1;
            elseif(field == "complex")
              xx[i] = complex( parse(Float64, flds[3]) , parse(Float64, flds[4])  ) ;
            end
            i = i+1;
            if symm == "symmetric"
               rr[i] = parse(Int, flds[2])
               cc[i] = parse(Int, flds[1])

	            if(field == "real" || field == "integer")
    	          xx[i] = parse(Float64, flds[3])
	            elseif(field == "pattern")
    	          xx[i] = 1;
        	    elseif(field == "complex")
              	  xx[i] = complex( parse(Float64, flds[3]) , parse(Float64, flds[4])  ) ;
	            end

               i = i+1;
            end
        end
        return mmStructure(domain, rep, field, symm, sparse(rr, cc, xx, rows, cols))
    end
    reshape([float64(readline(mmfile)) for i in 1:entries], (rows,cols))
end

mmread(filename::ASCIIString) = mmread(filename, false)

