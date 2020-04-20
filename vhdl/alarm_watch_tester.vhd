LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;

ENTITY alarm_watch_tester IS
    PORT
    (
        -- inputs
        bin_min1  : IN std_logic_vector(3 DOWNTO 0); --!
        bin_min10 : IN std_logic_vector(3 DOWNTO 0); --!
        bin_hrs1  : IN std_logic_vector(3 DOWNTO 0); --!
        bin_hrs10 : IN std_logic_vector(3 DOWNTO 0); --!
        clk       : IN std_logic;                    --!
        speed     : IN std_logic;                    --!
        reset     : IN std_logic;                    --!
        view      : IN std_logic;
        --outputs
        alarm     : OUT std_logic;
        buzzer    : OUT std_logic;
        HEX02     : OUT std_logic_vector(6 DOWNTO 0); --!
        HEX03     : OUT std_logic_vector(6 DOWNTO 0); --!
        HEX04     : OUT std_logic_vector(6 DOWNTO 0); --!
        HEX05     : OUT std_logic_vector(6 DOWNTO 0); --!
        HEX06     : OUT std_logic_vector(6 DOWNTO 0); --!
        HEX07     : OUT std_logic_vector(6 DOWNTO 0)  --!
    );
END ENTITY alarm_watch_tester;

ARCHITECTURE rtl OF alarm_watch_tester IS

    -- to mux
    SIGNAL mux_a_1         : std_logic_vector(6 DOWNTO 0);
    SIGNAL mux_a_2         : std_logic_vector(6 DOWNTO 0);
    SIGNAL mux_a_3         : std_logic_vector(6 DOWNTO 0);
    SIGNAL mux_a_4         : std_logic_vector(6 DOWNTO 0);
    SIGNAL mux_a_5         : std_logic_vector(6 DOWNTO 0);
    SIGNAL mux_a_6         : std_logic_vector(6 DOWNTO 0);

    SIGNAL mux_b_1         : std_logic_vector(6 DOWNTO 0);
    SIGNAL mux_b_2         : std_logic_vector(6 DOWNTO 0);
    SIGNAL mux_b_3         : std_logic_vector(6 DOWNTO 0);
    SIGNAL mux_b_4         : std_logic_vector(6 DOWNTO 0);
    SIGNAL mux_b_5         : std_logic_vector(6 DOWNTO 0);
    SIGNAL mux_b_6         : std_logic_vector(6 DOWNTO 0);
    --  tm signals
    SIGNAL tmSignal        : std_logic_vector(15 DOWNTO 0);
    SIGNAL timeAlarmSignal : std_logic_vector(15 DOWNTO 0);

BEGIN
    ----------------------------------------------------
    mainWatch : ENTITY watch
        PORT MAP
        (
            ---- Input
            clk    => clk,
            speed  => speed,
            reset  => reset,
            ---- Output
            sec_1  => mux_b_1,
            sec_10 => mux_b_2,
            min_1  => mux_b_3,
            min_10 => mux_b_4,
            hrs_1  => mux_b_5,
            hrs_10 => mux_b_6,
            tm     => tmSignal
        );
    --------------------------------------------------
    --------------------------------------------------

    SelectorMux : ENTITY mux
        PORT
        MAP(
        -- selector
        view => view,
        -- inputs
        -- Select A 
        a1   => "1111111",
        a2   => "1111111",
        a3   => mux_a_3,
        a4   => mux_a_4,
        a5   => mux_a_5,
        a6   => mux_a_6,
        -- Select B
        b1   => mux_b_1,
        b2   => mux_b_2,
        b3   => mux_b_3,
        b4   => mux_b_4,
        b5   => mux_b_5,
        b6   => mux_b_6,
        ----
        -- outputs
        o1   => HEX02,
        o2   => HEX03,
        o3   => HEX04,
        o4   => HEX05,
        o5   => HEX06,
        o6   => HEX07
        );

    --------------------------------------------------
    --------------------------------------------------
    inputLimiter : ENTITY inputLimiting
        PORT
        MAP
        (
        ---- Input
        bin_min1   => bin_min1,
        bin_min10  => bin_min10,
        bin_hrs1   => bin_hrs1,
        bin_hrs10  => bin_hrs10,
        ---- Output
        time_alarm => timeAlarmSignal
        );
    --------------------------------------------------
    --------------------------------------------------
    compareModule : ENTITY compareTime
        PORT
        MAP
        (
        -- input
        tm_watch => tmSignal,
        tm_alarm => timeAlarmSignal,
        -- output
        alarm    => alarm
        );
    --------------------------------------------------  
    --------------------------------------------------
    BuzzModule : ENTITY buzzing
        PORT
        MAP
        (
        -- input
        tm_watch => tmSignal,
        tm_alarm => timeAlarmSignal,
        clk      => clk,
        -- output
        buzzer   => buzzer
        );
    --------------------------------------------------
    --------------------------------------------------
    quadDisplay : ENTITY quadBin2Sevenseq
        PORT
        MAP
        (
        -- input 
        bin    => timeAlarmSignal,
        -- output
        min_1  => mux_a_3,
        min_10 => mux_a_4,
        hrs_1  => mux_a_5,
        hrs_10 => mux_a_6
        );
    --------------------------------------------------
END ARCHITECTURE rtl;