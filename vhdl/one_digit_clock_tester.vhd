LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;
ENTITY one_digit_clock_tester IS
    PORT
    (
        clk   : IN std_logic;                     -- Clockinput
        mode  : IN std_logic_vector(1 DOWNTO 0);  -- Mode select
        reset : IN std_logic;                     -- Reset in // Active low
        speed : IN std_logic;                     -- Speed selection // Active low

        seg   : OUT std_logic_vector(6 DOWNTO 0); -- Display output
        cout  : OUT std_logic                     -- Carry out
    );
END ENTITY one_digit_clock_tester;

ARCHITECTURE TestSetup OF one_digit_clock_tester IS

    SIGNAL MultiCounterOutput : std_logic_vector(3 DOWNTO 0);
    SIGNAL ClkOut             : std_logic;

BEGIN

    ClockGenerator : ENTITY clock_gen
        PORT MAP
        (
            clk     => clk,
            reset   => reset,
            speed   => speed,
            clk_Out => ClkOut
        );

    MultiCounter : ENTITY count_onedigit
        PORT
        MAP
        (
        clk               => clkOut,
        reset             => reset,
        mode(1 DOWNTO 0)  => mode(1 DOWNTO 0),
        count(3 DOWNTO 0) => MultiCounterOutput(3 DOWNTO 0),
        cout              => cout
        );

    Hexdisplay : ENTITY bin2hex
        PORT
        MAP
        (
        bin(3 DOWNTO 0)  => MultiCounterOutput(3 DOWNTO 0),
        sseg(6 DOWNTO 0) => seg(6 DOWNTO 0)
        );

END ARCHITECTURE TestSetup;