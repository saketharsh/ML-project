database = function(filename)
    datainput = {}
	dataoutput1 = {}
	i=0
	for line in io.lines(filename) do
		i=i+1
		date1,rating1,start1,hi1,low1,close1,vol1=unpack(line:split(","))
		local t={start1/10,hi1/10,low1/10,vol1/10000}
		table.insert(datainput,t)
		table.insert(dataoutput1,{close1/70})
	end
	dataoutput1 = torch.Tensor(dataoutput1)
	dataoutput = torch.Tensor(i)
	for k=1,i do
		dataoutput[k] = dataoutput1[k][1]
	end
    return {datainput = torch.Tensor(datainput),dataoutput = dataoutput}
end

fullset = database("Dataset.txt")

trainset = {
	size = 10000,
	data = fullset['datainput'][{{1,10000}}],
	label = fullset['dataoutput'][{{1,10000}}]
}

validationset = {
	size = 2955,
	data = fullset['datainput'][{{10001,12955}}],
	label = fullset['dataoutput'][{{10001,12955}}]
}
--print (trainset.data[{{1,10},1}])

