function  findMaxEig(M::MatrixProperty)
   try
		#M.maxEig = 0;
		#return;

   #[d,nconv, niter, nmult, resid] = eigs(M.mm.matrix; nev=6, ritzvec =false);
   d = eigs(M.mm.matrix; nev=6, ritzvec =false);
   #println( "d $(typeof(d))");
   #println( "d $(typeof(d[1]))");
   #println( "d $(d[1][1])");
   #println( "d2 $(d[1][1])");
   #println( "maxEig: $(d)");

   M.maxEig = d[1][1];
   return d;
   
   catch ex
	  println( "eig could not be found error: id $(M.UFindex) $(ex)");

	  d = eigs(M.mm.matrix; nev=20, ncv= 80 , ritzvec =false, maxiter= 900);
      M.maxEig = d[1][1];
 	  println( "  eig found at second iteration  id $(M.UFindex)  d $(d[1][1])");      
      return d;

	  #t = eigmax( Symmetric( (M.mm.matrix)'M.mm.matrix ));
	  #println( "$(t[1])");
   end

end;
