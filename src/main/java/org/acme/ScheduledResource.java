package org.acme;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import javax.enterprise.context.ApplicationScoped;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import io.quarkus.scheduler.Scheduled;

@ApplicationScoped
public class ScheduledResource {

    @ConfigProperty(name = "poll.url") 
    String url;

    @Scheduled(every="${poll.delay}")     
    void callUrl() {
        System.out.println("Calling " + url);
        try {
            httpGetRequest(url);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void httpGetRequest(String url) throws Exception {
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(url))
            .build();
        HttpResponse<String> response = client.send(request, BodyHandlers.ofString());
        System.out.println("Response status code: " + response.statusCode());
    }
}