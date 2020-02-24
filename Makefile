a:
	gcc -shared -fPIC libunionpreload.c -o libunionpreload.so -ldl -DUNION_LIBNAME=\"libunionpreload.so\"
	strip libunionpreload.so