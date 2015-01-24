<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.support.annotation.NonNull;

import ${config.providerJavaPackage}.base.MapDatabaseModelHandler;
import ${config.providerJavaPackage}.base.MapDatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Database model handler for the {@code ${entity.nameLowerCase}} table.
</#if>
 * <p>Used to read/write Map elements with {@link ${entity.nameCamelCase}Key}/{@link ${entity.nameCamelCase}Value} into a database
 * and select items using a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}Selection}</p>
 */
public class ${entity.nameCamelCase}MapDatabaseModelHandler extends MapDatabaseModelHandler<${entity.nameCamelCase}Key, ${entity.nameCamelCase}Value, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> {
    /**
     * Default Constructor.
     */
    public ${entity.nameCamelCase}MapDatabaseModelHandler() {
        this(new ${entity.nameCamelCase}MapDatabaseSerializer());
    }

    /**
     * Constructor.
     *
     * @param serializer transforms a {@link ${entity.nameCamelCase}Cursor} to a {@link ${entity.nameCamelCase}Model}
     *                   or a {@link ${entity.nameCamelCase}Model} into {@code ContentValues}
     * @see ${entity.nameCamelCase}MapDatabaseSerializer
     */
    public ${entity.nameCamelCase}MapDatabaseModelHandler(@NonNull MapDatabaseSerializer<${entity.nameCamelCase}Key, ${entity.nameCamelCase}Value, ${entity.nameCamelCase}Cursor> serializer) {
        super(serializer);
    }

    @Override
    protected ${entity.nameCamelCase}Selection getItemSelection(@NonNull ${entity.nameCamelCase}Key itemToSelect) {
        if (itemToSelect.getId() <= 0) {
            return new ${entity.nameCamelCase}Selection()
        <#list entity.getKeys() as key>
            <#if key.isId>
                .id(itemToSelect.getId())<#if !(key_has_next)>;<#else>.and()</#if>
            <#else>
                .<#if key.isForeign>${key.path?uncap_first}${key.nameCamelCase}<#else>${key.nameCamelCaseLowerCase}</#if>(itemToSelect.get<#if key.isForeign>${key.path}</#if>${key.nameCamelCase}())<#if !(key_has_next)>;<#else>.and()</#if>
            </#if>
        </#list>
        }
        return new ${entity.nameCamelCase}Selection().id(itemToSelect.getId());
    }
}