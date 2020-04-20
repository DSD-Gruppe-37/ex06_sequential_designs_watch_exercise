-------------------------------------------------------
--! @file
--! @brief  Two counters in one
-------------------------------------------------------
--! Use standard library
LIBRARY IEEE;

--! Use logic library
USE IEEE.std_logic_1164.ALL;
--! Use numeric library
USE IEEE.numeric_std.ALL;
USE WORK.ALL;

--! Two counter entity 

--! 
ENTITY TwoCounters IS
    PORT (
        clkIn      : IN std_logic;                     --! Clockinput
        modeOnes   : IN std_logic_vector(1 DOWNTO 0);  --! Mode select
        modeTens   : IN std_logic_vector(1 DOWNTO 0);  --! Mode select
        resetIn    : IN std_logic;                     --! Reset in // Active low
        segOnesOut : OUT std_logic_vector(6 DOWNTO 0); --! Display output
        segTensOut : OUT std_logic_vector(6 DOWNTO 0); --! Display output
        countOnes  : OUT std_logic_vector(3 DOWNTO 0); --! Ones binary output
        countTens  : OUT std_logic_vector(3 DOWNTO 0); --! Tens binary output
        coutOut    : OUT std_logic
    );
END ENTITY TwoCounters;

--! @brief Architecture definition of the two counter
--! @details More details about this two counter element.

ARCHITECTURE rtl OF TwoCounters IS
    SIGNAL clock_int        : std_logic;
    SIGNAL displayOnesCount : std_logic_vector(3 DOWNTO 0);
    SIGNAL displayTensCount : std_logic_vector(3 DOWNTO 0);
BEGIN
    --- count ones
    MultiCounterOnes : ENTITY multi_counter(ThreeMode)
        PORT MAP
        (
            clk   => clkIn,
            reset => resetIn,
            mode  => modeOnes,
            count => displayOnesCount,
            cout  => clock_int
        );
    --- count tens    
    MultiCounterTens : ENTITY multi_counter(ThreeMode)
        PORT MAP
        (
            clk   => clock_int,
            reset => resetIn,
            mode  => modeTens,
            count => displayTensCount,
            cout  => coutOut
        );
    -- display ones
    HexdisplayOnes : ENTITY bin2hex
        PORT MAP
        (
            bin => displayOnesCount,
            seg => segOnesOut
        );
    -- diplay tens
    HexdisplayTens : ENTITY bin2hex
        PORT MAP
        (
            bin => displayTensCount,
            seg => segTensOut
        );

    CountOnes <= displayOnesCount;
    CountTens <= displayTensCount;

END ARCHITECTURE rtl;