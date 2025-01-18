 
 import 'package:flutter/material.dart';

class WeatherInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const WeatherInfoCard({super.key, 
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

 
 
 final List<String> predefinedLocations = [
  'Mumbai',        
  'Delhi',       
  'Kolkata',      
  'Bengaluru',    
  'Chennai',     
  'Hyderabad',   
  'Ahmedabad',  
  'Pune',        
  'Jaipur',     
  'Chandigarh',  
  'Lucknow',      
  'Surat',         
  'Bhopal',     
  'Indore',     
  'Vadodara',     
  'Chandrapur',   
  'Nagpur',      
  'Coimbatore',   
  'Mysuru',       
  'Patna',       
  'Varanasi',    
  'Kanpur',      
  'Nashik',    
  'Agra',       
  'Gurugram',   
  'Noida',     
  'Vijayawada',    
  'Visakhapatnam',
  'Madurai',     
  'Rajkot',       
  'Shimla',       
  'Dehradun',  
  'Ranchi',     
  'Jammu',      
  'Udaipur',     
  'Jodhpur',      
  'Kochi',        
  'Thane',      
  'Faridabad',   
  'Tirunelveli',  
  'Kochi',      
  'Surat',       
  'Haldia',     
  'Dhanbad',    
  'Guwahati',    
  'Agartala',  
  'Imphal',     
  'Itanagar',    
  'Gangtok',     
  'Shillong',    
  'Kohima',      
  'Aizawl',     
  'Kottayam',   
];

