/*
 * This source is part of the
 *      _____  ___   ____
 *  __ / / _ \/ _ | / __/___  _______ _
 * / // / , _/ __ |/ _/_/ _ \/ __/ _ `/
 * \___/_/|_/_/ |_/_/ (_)___/_/  \_, /
 *                              /___/
 * repository.
 * 
 * Copyright (C) 2012-2014 Benoit 'BoD' Lubek (BoD@JRAF.org)
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package org.jraf.androidcontentprovidergenerator;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.jraf.androidcontentprovidergenerator.Main.Json;
import org.jraf.androidcontentprovidergenerator.model.DataSourceOutput;
import org.jraf.androidcontentprovidergenerator.model.Entity;
import org.jraf.androidcontentprovidergenerator.model.Model;
import org.json.JSONException;
import org.json.JSONObject;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @author Dell990MT
 *
 */
public class ContentProviderOutput extends DataSourceOutput {

	@Override
	public int hashCode() {
		return ContentProviderOutput.class.hashCode();
	}

	public void generateOutput(Configuration freeMarkerConfig, Arguments arguments, JSONObject config, Entity entity) throws IOException, JSONException, TemplateException {
		super.generateOutput(freeMarkerConfig, arguments, config, entity);
		
		final String providerJavaPackage = config.getString(Json.PROVIDER_JAVA_PACKAGE);
        final Map<String, Object> root = new HashMap<>();
        root.put("config", config);
        root.put("header", Model.get().getHeader());
        root.put("model", Model.get());
        root.put("entity", entity);

        final File providerDir = new File(arguments.outputDir, providerJavaPackage.replace('.', '/'));
        providerDir.mkdirs();
        final File outputDir = new File(providerDir, entity.getPackageName());
        outputDir.mkdirs();
        final File baseClassesDir = new File(providerDir, "base");
        baseClassesDir.mkdirs();

        Template template;
        File outputFile;
        
        // BaseContentProvider
        template = freeMarkerConfig.getTemplate("basecontentprovider.ftl");
        outputFile = new File(baseClassesDir, "BaseContentProvider.java");
        DataSourceOutput.writeOutput(template, outputFile, root);
        
        template = freeMarkerConfig.getTemplate("contentprovider.ftl");
        outputFile = new File(providerDir, config.getString(Json.PROVIDER_CLASS_NAME) + ".java");
        DataSourceOutput.writeOutput(template, outputFile, root);
	}

}
