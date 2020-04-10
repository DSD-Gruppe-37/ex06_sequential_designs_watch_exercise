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

    twentyFourReset : PROCESS (hrs_bin1, hrs_bin10, reset_in)
    BEGIN
        IF (hrs_bin1 = "0100" AND hrs_bin10 = "0010") THEN
            reset_out <= '0';
        ELSIF (reset_in = '0') THEN
            reset_out <= '0';
        ELSE
            reset_out <= '1';
        END IF;
    END PROCESS twentyFourReset;

    -- hardReset: process(reset_in)
    -- begin

    -- end process hardReset;
END ARCHITECTURE rtl;