Template.audience.rendered = () ->
  if Session.get 'd3_data'
    data = Session.get 'd3_data'
    width = 960 * .6
    height = 500 * .6
    radius = Math.min(width, height) / 2
    color = d3.scale.ordinal()
                    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"])
    arc = d3.svg.arc()
                .outerRadius(radius - 10)
                .innerRadius(radius - 70)
    pie = d3.layout.pie()
                  .sort(null)
                  .value (d) -> d.audience
    svg = d3.select(".audience_svg")
            .attr("width", width)
            .attr("height", height)
            .append("g")
            .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
    
    g = svg.selectAll(".arc").data(pie(data))
                              .enter()
                              .append("g")
                              .attr("class", "arc")

    g.append("path")
      .attr("d", arc)
      .style "fill", (d, i) -> color i

    g.append("text").attr("transform", (d) ->
      "translate(" + arc.centroid(d) + ")"
    ).attr("dy", ".35em").style("text-anchor", "middle").text (d) ->
      d.data.name
    return

Template.critics.rendered = () ->
  if Session.get 'd3_data'
    data = Session.get 'd3_data'
    width = 960 * .6
    height = 500 * .6
    radius = Math.min(width, height) / 2
    color = d3.scale.ordinal()
                    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"])
    arc = d3.svg.arc()
                .outerRadius(radius - 10)
                .innerRadius(radius - 70)
    pie = d3.layout.pie()
                  .sort(null)
                  .value (d) -> d.audience
    svg = d3.select(".critics_svg")
            .attr("width", width)
            .attr("height", height)
            .append("g")
            .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
    
    g = svg.selectAll(".arc").data(pie(data))
                              .enter()
                              .append("g")
                              .attr("class", "arc")

    g.append("path")
      .attr("d", arc)
      .style "fill", (d, i) -> color i

    g.append("text").attr("transform", (d) ->
      "translate(" + arc.centroid(d) + ")"
    ).attr("dy", ".35em").style("text-anchor", "middle").text (d) ->
      d.data.name
    return
