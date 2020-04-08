LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;

ENTITY test_bench IS
    PORT
    (
        SW   : IN std_logic_vector(17 DOWNTO 0);
        KEY  : IN std_logic_vector(3 DOWNTO 0);
        HEX0 : OUT std_logic_vector(6 DOWNTO 0);
        LEDR : OUT std_logic_vector(6 DOWNTO 0)
    );
END;

ARCHITECTURE structural OF test_bench IS

BEGIN

    MultiCounterTester : ENTITY multi_counter_tester
        PORT MAP
        (
            cout  => LEDR(0),
            seg   => HEX0,
            clk   => KEY(0),
            reset => key(3),
            mode  => SW(17 DOWNTO 16)
        );
END;