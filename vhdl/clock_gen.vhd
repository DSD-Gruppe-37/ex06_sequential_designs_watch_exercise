LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY clock_gen IS
    PORT
    (
        clk     : IN std_logic;
        reset   : IN std_logic;
        speed   : IN std_logic;

        clk_out : OUT std_logic;
    );
END ENTITY clock_gen;
ARCHITECTURE oneSecClock OF clock_gen IS

BEGIN

END ARCHITECTURE oneSecClock;