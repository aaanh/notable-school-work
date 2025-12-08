n <- 10;

# list of parents
l_p <- list();

# list of descendants
l_d <- list();


# returns all the children of individual i
children_of <- function(i){
	v_c <- vector();
	
	for (j in 1:n){
		if (is.element(i, l_p[[j]])){
			v_c <- append(v_c, j);
		}
	}
	
	return(v_c);
}


# initialize the list of descendants
for (i in 1:n){
	l_d[[i]] <- c(i);
}

# choose parents
for (i in 1:n){
	l_p[[i]] <- sample(1:n, size=2, replace=TRUE);
}



l_d_aux <- list()

# update list of descendants
for (i in 1:n){
	v_c_aux <- children_of(i);
	
	l_d_aux[[i]] <- vector();
	
	for (j in v_c_aux){
		l_d_aux[[i]] <- union(l_d_aux[[i]], l_d[[j]]);
	}
}

l_d <- l_d_aux;