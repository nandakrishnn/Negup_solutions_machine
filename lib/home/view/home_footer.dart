
import 'package:flutter/material.dart';
import 'package:negup_solutions_flutter/home/services/get_data.dart';
import 'package:negup_solutions_flutter/widgets/body_container.dart';
import 'package:provider/provider.dart';

class HomeFooterWidget extends StatelessWidget {
  const HomeFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GetDataFromShared>(builder: (context, sharedData, child) {
         final locations = sharedData.locations;
        if ( locations.isEmpty) {
          return const Center(child: Text('No Stored Locations'));
        }
      print(sharedData.locations);
    
      bool isTabView = MediaQuery.of(context).size.width >= 600;
    
      return sharedData.locations.isEmpty
          ? const Center(child: Text('No Stored Locations'))
          : isTabView  
       ? Expanded(
           child: GridView.builder(
             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2, 
               crossAxisSpacing: 5, 
               mainAxisSpacing: 2,  
               childAspectRatio: 3, 
             ),
             itemCount: sharedData.locations.length,
             itemBuilder: (context, index) {
                if(sharedData.locations.isEmpty){
              const  Text('No data available');
              }
               final location = sharedData.locations[index];
               return BodyContainerFooter(
                 request: 'Request' + '${index + 1}',
                 lat: location['latitude']?.toString() ?? 'N/A',
                      long: location['longitude']?.toString() ?? 'N/A',
                      speed: location['speed'] ?? 0,
               );
             },
           ),
         )
       : Expanded(
           child: ListView.builder(
             itemCount: sharedData.locations.length,
             itemBuilder: (context, index) {
              if(sharedData.locations.isEmpty){
               const Text('No data available');
              }
               final location = sharedData.locations[index];
               return BodyContainerFooter(
                 request: 'Request' + '${index + 1}',
                 lat: location['latitude']?.toString() ?? 'N/A',
                      long: location['longitude']?.toString() ?? 'N/A',
                      speed: location['speed'] ?? 00,
               );
             },
           ),
         );
    });
  }
}
