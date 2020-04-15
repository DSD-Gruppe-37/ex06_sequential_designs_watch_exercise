LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;

ENTITY multi_counter IS
    PORT (
        clk : IN std_logic;
        mode : IN std_logic_vector(1 DOWNTO 0);
        reset : IN std_logic; -- active low
        count : OUT std_logic_vector(3 DOWNTO 0);
        cout : OUT std_logic
    );
END ENTITY multi_counter;

ARCHITECTURE counter OF multi_counter IS
    SIGNAL internal_count : unsigned(3 DOWNTO 0) := "0000";
BEGIN
    PROCESS (clk, reset)
        VARIABLE maxValue : unsigned(3 DOWNTO 0);
    BEGIN
        IF reset = '0' THEN
            -- reset the counter
            internal_count <= "0000";
            cout <= '1';
        ELSIF rising_edge(clk) THEN
            -- set the maximum counter value
            CASE mode IS
                WHEN "00" => maxValue := to_unsigned(9, maxValue'length);
                WHEN "01" => maxValue := to_unsigned(5, maxValue'length);
                WHEN OTHERS => maxValue := to_unsigned(2, maxValue'length);
            END CASE;

            -- update counter
            IF (internal_count + 1) >= maxValue THEN
                internal_count <= "0000";
                cout <= '1';
            ELSE
                internal_count <= internal_count + 1;
                count <= '0';
            END IF;
        END IF;
    END PROCESS;

    count <= std_logic_vector(internal_count);
END;