package coreahblsram_pkg is
function SYNC_MODE_SEL( FAMILY: INTEGER) return INTEGER;
end coreahblsram_pkg;

package body coreahblsram_pkg is

	FUNCTION SYNC_MODE_SEL (FAMILY: INTEGER) RETURN INTEGER IS
        VARIABLE return_val : INTEGER := 0;
        BEGIN
		IF(FAMILY = 25) THEN
		    return_val := 1;
		ELSE
		    return_val := 0;
		END IF;
		RETURN return_val; 
	END SYNC_MODE_SEL;
		
end coreahblsram_pkg;