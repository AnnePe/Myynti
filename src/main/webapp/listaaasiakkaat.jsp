<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Myynnin asiakkaat</title>

</head>
<body>
<table id="listaus" border="1"> 
	<thead>
	<tr>
			<th colspan="6" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>				
		<tr>
			<th colspan="2" class="oikealle">Hakusana:</th>
			<th colspan="2" class="vasemmalle"><input type="text" id="hakusana"></th>
			<th colspan="2" class="vasemmalle"><input type="button" value="Hae" id="hakunappi"></th>
		</tr>
		<tr>
			<th class="vasemmalle">Id</th>
			<th class="vasemmalle">Etunimi</th>
			<th class="vasemmalle">Sukunimi</th>
			<th class="vasemmalle">Puhelin</th>
			<th class="vasemmalle">Sposti</th>
			<th></th>
										
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){                         //kaikki jquery hommat tän alle
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	haeAsiakkaat();
	$("#hakunappi").click(function(){
    	//console.log($("#hakusana").val()); /kutsu haku funktiota
    	haeAsiakkaat();
     });
	 $(document.body).on("keydown",function(event){
	    	if(event.which==13){
	    		haeAsiakkaat();
	    	}
	    });
	    $("#hakusana").focus();//viedään kursori haksuana kenttään
});
function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){   //Funktio palauttaa tiedot json-objektina
		$.each(result.asiakkaat, function(i, field){    //haetaan backendistä autot ajaxilla @webservlet"autot" Autot servletissä
        	var htmlStr;						   //määritellään metodi millä haeteen GET
        	htmlStr+="<tr id='rivi_"+field.asiakas_id+"'>";
        	htmlStr+="<td>"+field.asiakas_id+"</td>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";
        	htmlStr+="<td><span class='poista' onclick=poista("+field.asiakas_id+")>Poista</span></td>";//
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);//elementin id=listaus lisätään tbody
        });	
				
		//console.log(result); //jos haluat näyttää consolissa toimiiko ajax kutsu
	}});
}
function poista(asiakas_id){
		if(confirm("Poistetaanko asiakas id:llä " + asiakas_id +"?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+asiakas_id).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
	        	alert("Asiakas id:llä " + asiakas_id +" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	};
}


</script>
</body>
</html>