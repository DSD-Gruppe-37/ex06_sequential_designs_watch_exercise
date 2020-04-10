LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE WORK.ALL;
ENTITY TwoCounters IS
    PORT
    (
        clkIn      : IN std_logic;                     -- Clockinput
        modeOnes   : IN std_logic_vector(1 DOWNTO 0);  -- Mode select
        modeTens   : IN std_logic_vector(1 DOWNTO 0);  -- Mode select
        resetIn    : IN std_logic;                     -- Reset in // Active low
        segOnesOut : OUT std_logic_vector(6 DOWNTO 0); -- Display output
        segTensOut : OUT std_logic_vector(6 DOWNTO 0); -- Display output
        countOnes  : OUT std_logic_vector(3 DOWNTO 0); -- Ones binary output
        countTens  : OUT std_logic_vector(3 DOWNTO 0); -- Tens binary output
        coutOut    : OUT std_logic
    );
END ENTITY TwoCounters;

ARCHITECTURE rtl OF TwoCounters IS
    SIGNAL clock_int        : std_logic;
    SIGNAL displayOnesCount : std_logic_vector(3 DOWNTO 0);
    SIGNAL displayTensCount : std_logic_vector(3 DOWNTO 0);
BEGIN
    --- count ones
    MultiCounterOnes : ENTITY multi_counter
        PORT MAP
        (
            clk   => clkIn,
            reset => resetIn,
            mode  => modeOnes,
            count => displayOnesCount,
            cout  => clock_int
        );
    --- count tens    
    MultiCounterTens : ENTITY multi_counter
        PORT
        MAP
        (
        clk   => clock_int,
        reset => resetIn,
        mode  => modeTens,
        count => displayTensCount,
        cout  => coutOut
        );
    -- display ones
    HexdisplayOnes : ENTITY bin2hex
        PORT
        MAP
        (
        bin  => displayOnesCount,
        sseg => segOnesOut
        );
    -- diplay tens
    HexdisplayTens : ENTITY bin2hex
        PORT
        MAP
        (
        bin  => displayTensCount,
        sseg => segTensOut
        );

    CountOnes <= displayOnesCount;
    CountTens <= displayTensCount;
    
END ARCHITECTURE rtl;