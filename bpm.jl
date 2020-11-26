println("Loading packages...\n")

# import Pkg; Pkg.add(["UnicodePlots", "Statistics"])
using Statistics
using UnicodePlots

println("Done...\n")


function convert_to_bpm(ms_list)
  μ = mean(ms_list)
  bpm = Int(round(60_000 / μ))
end

function timeit()
  contiue = true
  times = []
  beats = 1
  while true
    now = time()
    my_input = readline()
    if my_input == "c"
      println("Ending")
      break
    elseif my_input == ""
      current = time()
      append!(times, (current - now) * 1_000)
      now = time()
      print("Beat!")
      if beats % 4 == 0 && beats <= 4
        ### Every four beats print BPM estimate
        println("Current BPM: $(convert_to_bpm(times))")
      elseif beats % 4 == 0
        ### Only use for last beats after the fourth, so that it converges quicly
        ### in case of errors when tapping
        println("Current BPM: $(convert_to_bpm(times[end-3:end]))")
      end
      beats += 1
    else
      println("Press space or \"c\"")
      contiue
    end
  end
  println("\n\n\n\nDo you want to see a histogram? y/n")

  while true
    answer = readline()
    if answer == "n"
      println("Okay, we're done!")
      break
    elseif answer == "y"
      println("Here you go:\n")
      print(histogram(round.(60_000 ./times), closed=:right, nbins=15))
      break
    end
  end
end

println("When ready hit Enter; to exit type 'c'")
while true
  ready = readline()
  if ready == ""
    println("Ok, go!")
    break
  else
    println("When ready hit Enter; to exit type 'c'")
  end
end


timeit()
