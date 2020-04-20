LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.ALL;

ENTITY multi_counter_tester IS
    PORT (
        SW  : IN std_logic_vector(17 DOWNTO 0);
        KEY : IN std_logic_vector(3 DOWNTO 0);
        HEX0,
        HEX1,
        HEX2,
        HEX3,
        HEX4 : OUT std_logic_vector(6 DOWNTO 0);
        LEDR : OUT std_logic_vector(3 DOWNTO 0);
        LEDG : OUT std_logic_vector(5 DOWNTO 0)
    );
END ENTITY multi_counter_tester;

ARCHITECTURE testbench OF multi_counter_tester IS
    SIGNAL countOut : std_logic_vector(3 DOWNTO 0);
BEGIN
    uut0 : ENTITY multi_counter
        PORT MAP
        (
            clk   => KEY(0),
            mode  => SW(17 DOWNTO 16),
            reset => KEY(3),
            count => countOut,
            cout  => LEDR(0)
        );
    uut1 : ENTITY bin2sevenseg
        PORT MAP
        (
            bin => countOut,
            seg => HEX0
        );
END ARCHITECTURE;