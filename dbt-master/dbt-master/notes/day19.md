# MySQL PSM

## Stored Procedure

```SQL
SHOW PROCEDURE STATUS LIKE 'sp_%';

SHOW CREATE PROCEDURE sp_getenamesal;
```

## Parameters in C

```C
// n = in param
int sqr1(int n) {
	return n * n;
}

// n = in param
// r = out param
void sqr2(int n, int *r) {
	*r = n * n;
}

// n = in-out param
void sqr3(int *n) {
	*n = (*n) * (*n);
}

int main() {
	int res;
	res = sqr1(5);
	printf("result : %d\n", res);

	sqr2(6, &res);
	printf("result : %d\n", res);

	res = 7;
	sqr3(&res);
	printf("result : %d\n", res);
	return 0;
}
```

## Params in Stored Procedure
* IN param (default) -- input to Procedure
* OUT param -- output from Procedure
* INOUT param -- input to Procedure and output from Procedure

