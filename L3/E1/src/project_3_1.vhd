library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity project_3_1 is
    generic (
        FREQ_IN : integer := 100e6; -- default arguments
        FREQ_OUT : integer := 73e6 -- can be changed when initializing the entity
    );
    port (
        CLK : in std_logic;
        T : out std_logic
    );
end project_3_1;

architecture Behavioral of project_3_1 is
    constant WIDTH : integer := integer(ceil(log2(real(FREQ_IN/FREQ_OUT)))); -- in order to know how many bits count has to have
    constant max_val : integer := FREQ_IN/FREQ_OUT; -- = T_out/T_in , how often out fits into in -> wait this amount of CLK cycles
    signal count : unsigned(WIDTH - 1 downto 0) := (others => '0');
begin
    process (CLK) is    
    begin
        if rising_edge(CLK) then
            T <= '0';
            count <= count + 1;
            if count = max_val - 1 then -- use max_val as trigger for a more precise new frequency, max_val-1 because count starts at 0
                T <= '1'; -- set T to '1' for one CLK cycle
                count <= (others => '0'); -- reset count
            end if;
        end if;
    end process;

end Behavioral;