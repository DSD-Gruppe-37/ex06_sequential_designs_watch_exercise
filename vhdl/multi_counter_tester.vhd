LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY multi_counter_tester IS
    PORT
    (
        clk   : IN std_logic                      -- Clockinput
        mode  : IN std_logic_vector(1 DOWNTO 0);  -- Mode select
        reset : IN std_logic;                     -- Reset in // Active low

        seg   : OUT std_logic_vector(7 DOWNTO 0); -- Display output
        cout  : OUT std_logic;                    -- Carry out

    );
END ENTITY multi_counter_tester;

ARCHITECTURE structural OF multi_counter_tester IS

    SIGNAL MultiCounterOutput : std_logic_vector(3 DOWNTO 0);
    
BEGIN
    MultiCounter : ENTITY multi_counter_tester
        PORT MAP
        (
            clk   => clk,
            reset => reset,
            mode  => mode,
            count => MultiCounterOutput,
            cout  => cout
        );
    Hexdisplay : ENTITY bin2hex(Behavioral)
        PORT
        MAP
        (
        -- INPUTS
        bin  => MultiCounterOutput,
        -- OUTPUTS
        sseg => seg
        );

END ARCHITECTURE structural;