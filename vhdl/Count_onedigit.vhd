LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Count_onedigit IS
    PORT
    (
        clk   : IN std_logic;
        reset : IN std_logic;
        mode  : IN std_logic_vector(1 DOWNTO 0);

        count : OUT std_logic_vector(3 DOWNTO 0);
        cout  : OUT std_logic;
    );
END ENTITY Count_onedigit;
ARCHITECTURE structural OF Count_onedigit IS

    SIGNAL intCount : unsigned(3 DOWNTO 0); --- 

BEGIN
    PROCESS (clk, reset)
        -- -- Mode selector
        -- CASE(mode) IS
        -- when "00" => [MAX_] <= "9";
        -- when "01" => [MAX_] <= "5";
        -- when OTHERS => [MAX_] <= "2";
        -- END CASE

    BEGIN
        IF (rising_edge(clk) THEN
            intCount <= intCount + 1;
        ELSIF (reset = '1')
            intCount = "0000";
        END IF;
    END IF;

    -- -- Set cout to 1 if counter = 0
    -- CASE(intCount) IS
    --     WHEN "0000" => cout <= "1"
    --     WHEN OTHERS => cout <= "0"
    -- END CASE;

END PROCESS

count <= std_logic_vector(intCount);

END ARCHITECTURE structural;