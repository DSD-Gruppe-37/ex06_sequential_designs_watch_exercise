LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY reset_logic IS
    PORT
    (
        -- inputs
        reset_in  : IN std_logic;
        hrs_bin1  : IN std_logic_vector(3 DOWNTO 0);
        hrs_bin10 : IN std_logic_vector(3 DOWNTO 0);
        -- outputs 
        reset_out : OUT std_logic
    );
END ENTITY reset_logic;

ARCHITECTURE rtl OF reset_logic IS

BEGIN
    reset_out <= reset_in;
END ARCHITECTURE rtl;