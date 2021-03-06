assessSymmetry = function(bpMat, bpGraph = FALSE,
  	prob=0.5, pLevels=1e-4) {
    if (bpGraph){
        bpMat <- as(bpMat, "matrix")
    }
    
    stopifnot(all(bpMat %in% 0:1))
    bpMat = bpMat>0
    deg <- cbind(nr=rowSums(bpMat&t(bpMat)), no=rowSums(bpMat&(!t(bpMat))),
                 ni=rowSums((!bpMat)&t(bpMat)))

     
    nunrec = deg[, "no"]+deg[, "ni"]
    nmini  = pmin(deg[, "no"], deg[, "ni"])
    n2 <- nunrec - nmini - 1
    p1 = pbinom(nmini, size=nunrec, prob=prob)
    p2 <- 1 - pbinom(n2, size=nunrec, prob=prob)
    p = pmin(p1+p2, 1) 
    nmax = 2*max(deg[, "no"], deg[, "ni"])
    contours = sapply(pLevels, qbinom, size=0:nmax, prob=prob)

    list(deg=deg, p=p, contours=contours)
    
}

