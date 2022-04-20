library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity project_6_3 is
    port (
        CLK : in std_logic;
        SPK : out std_logic
    );
end project_6_3;

architecture Behavioral of project_6_3 is
    type state_type is (wait_state, melody, stop);
    signal state : state_type := melody;
    signal freq : std_logic_vector(15 downto 0) := (others => '0');
    constant wait_150 : integer range 0 to 160e5 := 150e5; -- use this value together with count
    signal count : integer range 0 to 100e6 - 1 := 0; -- to wait for 150ms in wait_state

begin

    sound : entity work.Frequency_Generator
        port map(
            CLK => CLK,
            FREQ => freq,
            SND => SPK
        );

    process (CLK) is
        variable freq_counter : integer range 0 to 9 := 0; -- counter for different frequencies
    begin
        if rising_edge(CLK) then
            case state is
                when wait_state =>
                    count <= count + 1;
                    if count = wait_150 - 1 then -- wait for 150ms
                        count <= 0;
                        freq_counter := freq_counter + 1; -- go to the next frequency in the melody state
                        state <= melody;
                    end if;
                when melody =>
                    if freq_counter = 0 then
                        freq <= std_logic_vector(TO_UNSIGNED(392, 16));
                        state <= wait_state;
                    elsif freq_counter = 1 then
                        freq <= std_logic_vector(TO_UNSIGNED(370, 16));
                        state <= wait_state;
                    elsif freq_counter = 2 then
                        freq <= std_logic_vector(TO_UNSIGNED(311, 16));
                        state <= wait_state;
                    elsif freq_counter = 3 then
                        freq <= std_logic_vector(TO_UNSIGNED(220, 16));
                        state <= wait_state;
                    elsif freq_counter = 4 then
                        freq <= std_logic_vector(TO_UNSIGNED(208, 16));
                        state <= wait_state;
                    elsif freq_counter = 5 then
                        freq <= std_logic_vector(TO_UNSIGNED(330, 16));
                        state <= wait_state;
                    elsif freq_counter = 6 then
                        freq <= std_logic_vector(TO_UNSIGNED(415, 16));
                        state <= wait_state;
                    elsif freq_counter = 7 or freq_counter = 8 then -- run this frequency 2 times for a total time of 300ms
                        freq <= std_logic_vector(TO_UNSIGNED(523, 16));
                        state <= wait_state;
                    else
                        state <= stop; -- end of melody
                    end if;
                when stop =>
                    freq <= std_logic_vector(TO_UNSIGNED(0, 16));
            end case;
        end if;
    end process;
end architecture Behavioral;