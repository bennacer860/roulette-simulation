class Roulette
	
	
	attr_accessor :account
	attr_accessor :times
	
	
	
	def initialize(account, benefit,changeColor)
		@changeColor
		@benefit=benefit
		@initialDate=Time.now
		@initialAccount=account
		@account=account
		@myColor=1
		@bet = [0.25 , 0.5 ,1 , 2.5 , 5 , 10]
		simulate
		result
        end
	
	
	
	
	#lose or win
	def win?(color)
		if(@myColor==color)
			return true
		else
			return false
		end
	end
	
	#return color : 1 for black and 0 for red
	def giveColor
		return  rand(2)
	end	
	
	
	#change your color
	def changeColor
		if(@myColor == 1)
			@myColor = 0
		elsif(@myColor ==0)
			@myColor =1
		end
	end
	
	
	
	def simulate
	#what was the maximum of your account	
	@max=@initialAccount
	#how many time have we played
	@times=0	
	#the size of the Array that contain the amounts we can bet
	betSize=@bet.size - 1
	#an index that points to the value to bet
	betAmount=0
			#if we still have the minimum bet we can play .the rules are simple if we win we would win the amount that we have bet ,the opposite goes for when we lose
			while(@account >= @bet[0]   and @account <= @benefit)
			#how many time have we played
			@times+=1
				#if we win the bet we reset the betAmount
				color=giveColor
				#color=0  
				#puts "the color is #{color}"
				if(win?(color))
					#~ puts "you have won: #{@bet[betAmount]} and your account has: #{@account} dollars "
					@account+=@bet[betAmount]
					betAmount=0
					#setting the maximum amount
					if(@account > @max)
						@max = @account
					end
					#if the change color flag is set to true make the change every time we win
					if( @changeColor)
					    changeColor
					end
				else

					#else we double our betAmount (one important rule is that we can't bet more than 10)
					#if the amount to bet is greater than the amount that we have in our account we can not bet 
					if(@bet[betAmount] <= @account)
						#~ puts "you have lost: #{@bet[betAmount]} and your account has: #{@account} dollars "
						@account-=@bet[betAmount]
						#if we want to bet more than the limit , do nothing
						if( betAmount < betSize )
							betAmount+=1
						end
					else	
						#~ puts "#################################################"
						#~ puts "Insufficiant amount to bet, you dont have #{@bet[betAmount]} dollars , account=#{@account}"
						
						if(@account != 0)
							betAmount=0
							#~ puts "you are loosing too much , lets reset our gambling to have a chance to catch up ,account=#{@account}"
						else	
							return
						end
					end
				end
			end
	end
	
	def result
		#~ benefit = @account - @initialAccount
		#~ percentage=(@account - @initialAccount)/@initialAccount * 100
		#~ duration = Time.now - @initialDate 
		#~ puts "your account has #{@account} , the percentage is #{percentage}% the difference is #{benefit}"
		#~ puts "you played :#{@times-1} times and the maximum amount was #{@max}"
		#~ puts "the duration of the game was #{duration} seconds"

		#have we met our objectives
		if(@account >= @benefit)
			return true
		else
			return false
		end		
	end
	
end

class Simulation
	
	def   initialize(n,changeColor)
		@nGame=n
		d=Time.now
		win=0
		games=0
		0.upto(@nGame -1) do
		r=Roulette.new(20,40,changeColor)	
			if(r.result == true )
				win+=1
				games+=(r.times )-1
			end
		end
	puts "Win probability is :#{(win*100)/@nGame}% in #{games/@nGame}"
	puts "The operations took #{Time.now-d} seconds"
	end
	
	
end

puts "#simulation with change color"
Simulation.new(10000,true)
puts "#simulation without change color"
Simulation.new(10000,false)